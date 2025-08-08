#! /usr/bin/env bash

# The scripts installs Ansible. It is one of the first steps in setting up
# the environment both for the local machine and dev containers.

set -e

if ! command -v ansible-playbook &> /dev/null; then
  echo "🚧 Installing Ansible..."
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    brew update
    brew install ansible
  else
    # Linux (Debian/Ubuntu)
    echo "$SUDO_PASSWORD" | sudo -S apt-get update
    echo "$SUDO_PASSWORD" | sudo -S apt install software-properties-common --yes
    echo "$SUDO_PASSWORD" | sudo -S add-apt-repository --yes --update ppa:ansible/ansible
    echo "$SUDO_PASSWORD" | sudo -S apt-get install --yes ansible
  fi
else
  echo "✅ Ansible is already installed, skipping..."
fi