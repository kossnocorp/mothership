#! /usr/bin/env bash

# The scripts installs Homebrew. It is the first step in setting up
# the environment for macOS systems.

if [[ "$OSTYPE" == "darwin"* ]]; then
  if ! command -v brew &> /dev/null; then
    echo "🚧 Installing Homebrew..."
    $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)
  else
    echo "✅ Homebrew is already installed, skipping..."
  fi
else
  echo "🆗️ Skipping Homebrew installation for non-macOS systems..."
fi