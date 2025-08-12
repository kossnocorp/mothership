#! /usr/bin/env bash

# The scripts installs stack using global mise config. It is used in
# images as the last step.

# Consts
mise_config="$HOME/.config/mise/mise.toml"

# Check if the config exists:
if [ ! -f "$mise_config" ]; then
  echo "🛑 Mise config not found!"
  exit 1
fi

# Ensure the config is owned by the current user
sudo chown "$USER:$USER" "$mise_config"

# Install stack & tools
PATH="$HOME/.local/bin:$PATH"
eval "$(mise activate bash --shims)"
mise install