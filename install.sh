#! /usr/bin/env bash

# The scripts set ups a local machine. It reuses the same scripts and structure
# as dev container images.

set -e

# Prepare

# Prompt sudo passwor
while true; do
  echo "🔒 Enter sudo password:"
  read -s SUDO_PASSWORD
  echo "🚧 Verifying password..."

  # Test if the password is correct
  if echo "$SUDO_PASSWORD" | sudo -S true 2>/dev/null; then
    echo "👍 The password is correct."
    break
  else
    echo "🛑 Incorrect password. Please try again."
  fi
done

export ANSIBLE_BECOME_PASS=$SUDO_PASSWORD
export SUDO_PASSWORD

# Assign GitHub username
GITHUB_USERNAME="${GITHUB_USERNAME:-kossnocorp}"
echo "💡 Using GitHub username: $GITHUB_USERNAME (override it with GITHUB_USERNAME)"

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

echo "⭐️ Installation complete! Please restart your terminal to apply changes."