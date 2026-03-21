#!/bin/bash
exec > /var/log/user-data.log 2>&1
set -eux

echo "Updating system..."
dnf update -y

echo "Installing Java..."
dnf install -y java-17-amazon-corretto

echo "Installing Git..."
dnf install -y git

echo "Installing Terraform..."
dnf install -y dnf-plugins-core
dnf config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
dnf install -y terraform

echo "Adding Jenkins repo..."
wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

echo "Installing Jenkins..."
dnf install -y jenkins

echo "Starting Jenkins..."
systemctl enable jenkins
systemctl start jenkins

echo "Jenkins installation completed!"