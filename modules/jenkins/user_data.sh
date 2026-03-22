#!/bin/bash
set -ex

dnf update -y
dnf install -y java-17-amazon-corretto wget

# Install Jenkins repo
wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
dnf install -y jenkins

# ---- IMPORTANT PART ----

# Disable setup wizard BEFORE first start
mkdir -p /etc/systemd/system/jenkins.service.d

cat <<EOF > /etc/systemd/system/jenkins.service.d/override.conf
[Service]
Environment="JAVA_OPTS=-Djenkins.install.runSetupWizard=false"
EOF

systemctl daemon-reexec
systemctl daemon-reload

# Create init script BEFORE start
mkdir -p /var/lib/jenkins/init.groovy.d

cat <<'EOF' > /var/lib/jenkins/init.groovy.d/basic-security.groovy
#!groovy

import jenkins.model.*
import hudson.security.*

def instance = Jenkins.get()

println("Creating admin user")

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("admin","Admin@123")
instance.setSecurityRealm(hudsonRealm)

def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)

instance.save()
EOF

chown -R jenkins:jenkins /var/lib/jenkins

# NOW start Jenkins FIRST TIME
systemctl enable jenkins
systemctl start jenkins