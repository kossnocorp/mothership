#! /usr/bin/env bash

# The scripts set ups a local machine. It reuses the same scripts and structure
# as dev container images.

set -e

echo "⭐️ Installation complete!"

printf "⚡️ Setting up development environment...\n\n"

#region Prepare

#region .env

# Try loading .env.install
if [ -f .env.install ]; then
  set -a && source .env.install && set +a
  printf "🔵 Loaded environment variables from .env.install\n\n"
elif [ -f .env ]; then
  set -a && source .env && set +a
  printf "🔵 Loaded environment variables from .env\n\n"
fi

#endregion

#region GitHub token

# Test if GITHUB_TOKEN is set
if [ -n "$GITHUB_TOKEN" ]; then
  last=${GITHUB_TOKEN: -4}
  echo "🔵 Using GitHub access token: ****${last}"
else
  echo "🟡 GITHUB_TOKEN is not set, mise installs might take longer than usual."
  # Wait for user to confirm continue
  read -p "❔ Press Enter to continue or Ctrl+C to exit..."
  printf "\n"
fi

# Clear GITHUB_TOKEN to prevent leaks
github_token="$GITHUB_TOKEN"
export GITHUB_TOKEN=""

#endregion

#region GitHub username

# Assign GitHub username
SKIP_DOTFILES=${SKIP_DOTFILES:-0}
if [ -n "$GITHUB_USERNAME" ]; then
  echo "🔵 Using GitHub username $GITHUB_USERNAME"
else
  echo "🟠 I need your GitHub username to install dotfiles from (USERNAME/dotfiles)."
  while true; do
    read -p "👤 Enter your GitHub username: " GITHUB_USERNAME
    if [ -n "$GITHUB_USERNAME" ]; then
      break
    else
      echo "🟠 Username is empty, dotfiles won't install."
      read -r -p "❔️️ Skip dotfiles installation? [Y/n] " yn
      case "$yn" in
        [Nn]*) ;;
        *)
          echo "🟡 Skipping dotfiles installation."
          break
          ;;
      esac
    fi
  done

  if [ -n "$GITHUB_USERNAME" ]; then
    echo "🔵 Using GitHub username: $GITHUB_USERNAME"
    echo "🟣 Set GITHUB_USERNAME to skip the prompt next time."
  fi
fi

export GITHUB_USERNAME

printf "\n"

#endregion

#region Sudo password

activate_sudo () {
  printf "%s\n" "${SUDO_PASSWORD:-$sudo_password}" | sudo -S -p "" -v >/dev/null 2>&1
}

keep_sudo_alive() {
  while true; do
    activate_sudo
    sleep 30
  done
}

has_password_env=false
if [ -n "$SUDO_PASSWORD" ]; then
  echo "🔵 Using sudo password ****"
  has_password_env=true
fi

while true; do
  # Prompt sudo password
  if [ -z "$SUDO_PASSWORD" ]; then
    if [ "$explained_password" != true ]; then
      echo "🟠 I need your sudo password for installing dependencies."
      explained_password=true
    fi
    echo "🔒 Enter sudo password:"
    read -s SUDO_PASSWORD
  fi

  # Test if the sudo password is correct
  echo "🚧 Verifying password..."
  if activate_sudo; then
    echo "🟢 The sudo password is correct."
    if [ "$has_password_env" != true ]; then
      echo "🟣 Set SUDO_PASSWORD to skip the prompt next time."
    fi
    printf "\n"
    break
  else
    echo "🔴 Incorrect password. Please try again."
    # Clear to force re-prompt next iteration
    SUDO_PASSWORD=""
  fi
done

# Keep sudo alive
activate_sudo
keep_sudo_alive & SUDO_KEEPALIVE_PID=$!
trap 'kill "$SUDO_KEEPALIVE_PID" 2>/dev/null' EXIT

# Clear SUDO_PASSWORD to prevent leaks
sudo_password="$SUDO_PASSWORD"
export SUDO_PASSWORD=""

#endregion

#endregion

#endregion

#region Install

echo "⚡️ Installing dependencies..."

#region Base

# Install Homebrew (macOS only)
./setup/scripts/homebrew.sh

# Install Ansible
./setup/scripts/ansible.sh

printf "\n"

#endregion

#region Playbooks

export ANSIBLE_BECOME_PASS="$sudo_password"

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

# Install age
echo "🚧 Setting up age..."
ansible-playbook $playbooks/age.yaml --inventory=$inventory

# Install SOPS
echo "🚧 Setting up SOPS..."
ansible-playbook $playbooks/sops.yaml --inventory=$inventory

# Install 1Password CLI
echo "🚧 Setting up 1Password CLI..."
ansible-playbook $playbooks/1password-cli.yaml --inventory=$inventory

# Install age-op
echo "🚧 Setting up age-op..."
ansible-playbook $playbooks/age-op.yaml --inventory=$inventory

# Install op-agent
echo "🚧 Setting up op-agent..."
ansible-playbook $playbooks/op-agent.yaml --inventory=$inventory

# Clear ANSIBLE_BECOME_PASS to prevent leaks
ANSIBLE_BECOME_PASS=""

#endregion

#endregion

echo "⭐️ Installation complete!"

# Detect shell and suggest command to restart

printf "\n💡 To activate changes, restart your terminal"

case "$(basename "$SHELL")" in
  bash) restart_cmd='source ~/.bashrc' ;;
  zsh)  restart_cmd='source ~/.zshrc' ;;
  fish) restart_cmd='exec fish' ;;
  *)    restart_cmd='' ;;
esac

if [ -n "$restart_cmd" ]; then
   printf "or run:\n\n    $restart_cmd\n"
else
  printf "\n"
fi