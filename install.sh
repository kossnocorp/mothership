#! /usr/bin/env bash

# The scripts set ups a local machine. It reuses the same scripts and structure
# as dev container images.

set -e

# Prepare

# Prompt sudo
sudo -v

# Assign GitHub username
GITHUB_USERNAME=${GITHUB_USERNAME:-kossnocorp}
echo "💡 Using GitHub username: $GITHUB_USERNAME (override it with `GITHUB_USERNAME`)"

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
ansible-playbook $playbooks/fish.yaml --inventory=$inventory

# Install Starship
echo "🚧 Setting up Starship..."
ansible-playbook $playbooks/starship.yaml --inventory=$inventory

# Install chezmoi
echo "🚧 Setting up chezmoi..."
ansible-playbook $playbooks/chezmoi.yaml --inventory=$inventory --extra-vars "GITHUB_USERNAME=$GITHUB_USERNAME"

# Install mise
echo "🚧 Setting up mise..."
ansible-playbook $playbooks/mise.yaml --inventory=$inventory

# Install Neovim
echo "🚧 Setting up NeoVim..."
ansible-playbook $playbooks/neovim.yaml --inventory=$inventory