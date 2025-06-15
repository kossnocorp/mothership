#!/usr/bin/env bash

set -e

eval "$(mise activate bash --shims)"

just --completions fish > ~/.config/fish/completions/just.fish