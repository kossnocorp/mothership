#!/usr/bin/env bash

# This script is when the container is updated.

set -e

# Pull git submodules
git submodule update --recursive --init --remote

# Trust all mise configs
mise trust --yes --all
git submodule foreach --recursive "mise trust"

# Update mise
mise self-update -y

# Install stack
mise install

#region Rust

# Install dependencies
if [ -f ./Cargo.lock ]; then
  cargo build || echo "🟡 Cargo build failed, but that's ok"
fi

#endregion

#region Node.js

# Install dependencies
if [ -f ./pnpm-lock.yaml ]; then
  yes | pnpm install
else if [ -f ./yarn.lock ]; then
  yes | yarn install
else if [ -f ./package-lock.json ]; then
  yes | npm install
fi

#endregion

#region Go

if [ -f ./go.mod ]; then
  # Install dependencies
  go mod download

  # Build the project
  go build || echo "🟡 Go build failed, but that's ok"
fi

#endregion