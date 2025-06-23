#!/usr/bin/env bash

# This script is run after the container is updated.

set -e

eval "$(mise activate bash --shims)"

# Update mise
mise self-update -y