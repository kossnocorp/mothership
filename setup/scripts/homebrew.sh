#! /usr/bin/env bash

# The scripts installs Homebrew. It is the first step in setting up
# the environment for macOS systems.

if [[ "$OSTYPE" == "darwin"* ]]; then
  #region Install

  if ! command -v "$BREW_BIN" &> /dev/null; then
    printf "\n🚧 Installing Homebrew...\n\n"
    NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "🟢 Homebrew successfully installed!"
  else
    echo "⚪️ Homebrew is already installed."
  fi

  #endregion

  #region Shell

  shell_integration="eval \"\$($BREW_BIN shellenv)\""

  if ! grep -q "$shell_integration" ~/.bashrc; then
    printf "\n$shell_integration\n" >> ~/.bashrc
    echo "🚧 Adding Homebrew to bash shell configuration..."
  fi

  if ! grep -q "$shell_integration" ~/.zshrc; then
    printf "\n$shell_integration\n" >> ~/.zshrc
    echo "🚧 Adding Homebrew to zsh shell configuration..."
  fi

  if ! grep -q "$shell_integration" ~/.config/fish/config.fish; then
    mkdir -p ~/.config/fish/
    printf "\n$shell_integration\n" >> ~/.config/fish/config.fish
    echo "🚧 Adding Homebrew to fish shell configuration..."
  fi

  #endregion
else
  echo "⚫️️ Skipping Homebrew installation for non-macOS systems."
fi
