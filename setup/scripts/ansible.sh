#! /usr/bin/env bash

# The scripts installs Ansible. It is one of the first steps in setting up
# the environment both for the local machine and dev containers.

set -e

if ! command -v ansible-playbook &> /dev/null; then
  printf "\n🚧 Installing Ansible...\n\n"

  if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    $BREW_BIN update
    $BREW_BIN install ansible
  else
    # TODO: Test if I need to rollback to this approach:
    # echo "$SUDO_PASSWORD" | sudo -S apt-get update
    # echo "$SUDO_PASSWORD" | sudo -S apt install software-properties-common --yes
    # echo "$SUDO_PASSWORD" | sudo -S add-apt-repository --yes --update ppa:ansible/ansible
    # echo "$SUDO_PASSWORD" | sudo -S apt-get install --yes ansible
    # Linux (Debian/Ubuntu)
    sudo apt-get update
    sudo apt install software-properties-common --yes
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt-get install --yes ansible
  fi

  echo "🟢 Ansible successfully installed!"
else
  echo "⚪️ Ansible is already installed."
fi