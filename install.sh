#! /usr/bin/env bash

# The scripts set ups a local machine. It reuses the same scripts and structure
# as dev container images.

set -e

# Prepare

# Prompt sudo
sudo -v

# Ask GitHub username for chezmoi
read -p "Enter your GitHub username for dotfiles [kossnocorp]: " github_username
github_username=${github_username:-kossnocorp}

echo "💡 Using GitHub username: $github_username"

# Base

# Install Homebrew (macOS only)
./setup/scripts/homebrew.sh

# Install Ansible
./setup/scripts/ansible.sh

# Playbooks

# Consts
playbooks="setup/playbooks"
inventory="setup/playbooks/inventory.ini"

# Install fish
echo "🚧 Setting up fish..."
ansible-playbook $playbooks/fish.yaml --inventory=$inventory --become

# Install chezmoi
echo "🚧 Setting up chezmoi..."
ansible-playbook $playbooks/chezmoi.yaml --inventory=$inventory --become --extra-vars "GITHUB_USERNAME=$github_username"

# Install Starship
echo "🚧 Setting up Starship..."
ansible-playbook $playbooks/starship.yaml --inventory=$inventory --become

# Install mise
echo "🚧 Setting up mise..."
ansible-playbook $playbooks/mise.yaml --inventory=$inventory --become