#!/usr/bin/env bash

# This script is run after the container is created.

set -e

eval "$(mise activate bash --shims)"

just --completions fish > ~/.config/fish/completions/just.fish