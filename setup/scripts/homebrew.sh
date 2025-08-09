#! /usr/bin/env bash

# The scripts installs Homebrew. It is the first step in setting up
# the environment for macOS systems.

if [[ "$OSTYPE" == "darwin"* ]]; then
  . ./export-brew-bin.sh

  #region Install

  if ! command -v "$BREW_BIN" &> /dev/null; then
    printf "\n🚧 Installing Homebrew...\n\n"
    NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "🟢 Homebrew successfully installed!"
  else
    printf "\n⚪️ Homebrew found.\n"
  fi

  #endregion

  #region Shell

  shell_integration="eval \"\$($BREW_BIN shellenv)\""

  # Bash
  if ! grep -q "$shell_integration" ~/.bashrc 2>/dev/null; then
    echo "🚧 Adding Homebrew to bash shell configuration..."
    cat <<EOF >> ~/.bashrc
if [[ "\$OSTYPE" == "darwin"* ]]; then
  $shell_integration
fi
EOF
  fi

  # Zsh
  if ! grep -q "$shell_integration" ~/.zshrc 2>/dev/null; then
    echo "🚧 Adding Homebrew to zsh shell configuration..."
    cat <<EOF >> ~/.zshrc
if [[ "\$OSTYPE" == "darwin"* ]]; then
  $shell_integration
fi
EOF
  fi

  # Fish
  if ! grep -q "$shell_integration" ~/.config/fish/config.fish 2>/dev/null; then
    echo "🚧 Adding Homebrew to fish shell configuration..."
    mkdir -p ~/.config/fish/
    cat <<EOF >> ~/.config/fish/config.fish
if test (uname) = Darwin
  $shell_integration
end
EOF
  fi

  #endregion
else
  printf "\n⚫️️ Skipping Homebrew installation for non-macOS systems.\n"
fi
