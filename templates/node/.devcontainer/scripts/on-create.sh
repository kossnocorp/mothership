#!/usr/bin/env bash

# This script is run when the container is created.

set -e

# Activate mise
eval "$(mise activate bash --shims)"

# Trust mise setup first
mise trust

# Update mise
mise self-update -y

# Install project mise dependencies
mise install