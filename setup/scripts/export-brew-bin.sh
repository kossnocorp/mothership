#! /usr/bin/env bash

# The scripts exports BREW_BIN. So that it can be used in other scripts.

# TODO: Detect Intel Macs
if [ -z "$BREW_BIN" ]; then
  export BREW_BIN="/opt/homebrew/bin/brew"
fi