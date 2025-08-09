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
    # Linux (Debian/Ubuntu)
    sudo apt-get update
    sudo apt install software-properties-common --yes
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt-get install --yes ansible
  fi

  echo "🟢 Ansible successfully installed!"
else
  printf "\n⚪️ Ansible found.\n"
fi