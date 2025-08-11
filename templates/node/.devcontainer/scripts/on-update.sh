#!/usr/bin/env bash

# This script is when the container is updated.

set -e

# Activate mise
eval "$(mise activate bash --shims)"

# Update mise
mise self-update -y

# Install project mise dependencies
mise install