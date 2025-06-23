# base

build-base:
  docker build -t kossnocorp/dev-base templates/base

publish-base:
  docker push kossnocorp/dev-base

# Node.js

up-node:
  devcontainer build --workspace-folder workspaces/node
  devcontainer up --workspace-folder workspaces/node

build-node:
  docker build -t kossnocorp/dev-node templates/node

publish-node:
  docker push kossnocorp/dev-node

# Rust

build-rust:
  docker build -t kossnocorp/dev-rust templates/rust

publish-rust:
  docker push kossnocorp/dev-rust

# esp-rs

up-esp-rs:
  devcontainer build --workspace-folder workspaces/esp-rs
  devcontainer up --workspace-folder workspaces/esp-rs

build-esp-rs:
  docker build -t kossnocorp/dev-esp-rs templates/esp-rs

publish-esp-rs:
  docker push kossnocorp/dev-esp-rs

# Dev Containers

publish-templates:
  devcontainer templates publish -r ghcr.io -n kossnocorp/templates ./templates