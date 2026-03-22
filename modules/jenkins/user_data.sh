#!/bin/bash
# Update system
dnf update -y

# Install Java
dnf install java-17-amazon-corretto -y
#wget install
sudo dnf install wget -y

#wget version check
wget --version

# Add Jenkins repo
wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Install Jenkins
dnf install jenkins -y

# Enable & start Jenkins
systemctl enable jenkins
systemctl start jenkins

# Open firewall (if enabled)
systemctl restart jenkins

echo "Waiting for Jenkins to generate admin password..."

# WAIT LOOP (VERY IMPORTANT)
while [ ! -f /var/lib/jenkins/secrets/initialAdminPassword ]; do
  sleep 15
done

echo "Password found. Uploading to S3..."

aws s3 cp \
/var/lib/jenkins/secrets/initialAdminPassword \
s3://mohini-jenkins-artifacts-f8b50037/initialAdminPassword.txt \
--region ap-south-1
