#!/bin/bash

set -e

# Update system
dnf update -y

# Install required packages
dnf install -y java-21-amazon-corretto
dnf install -y wget

# Install Docker
dnf install -y docker

systemctl enable docker
systemctl start docker

# Allow Jenkins user to access Docker
usermod -aG docker jenkins || true

# Install Jenkins repository
wget -O /etc/yum.repos.d/jenkins.repo \
  https://pkg.jenkins.io/redhat-stable/jenkins.repo

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2026.key

# Install Jenkins
dnf install -y jenkins

systemctl enable jenkins
systemctl start jenkins

# Install AWS CLI
dnf install -y awscli

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

rm -f kubectl

# Install Terraform
TERRAFORM_VERSION="1.13.0"

curl -LO "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"

unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip

mv terraform /usr/local/bin/

rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Create Jenkins workspace directory
mkdir -p /var/lib/jenkins/workspace

chown -R jenkins:jenkins /var/lib/jenkins/workspace

# Restart Jenkins so Docker group membership is applied
systemctl restart jenkins