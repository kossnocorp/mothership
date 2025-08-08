# Composite

build: build-base build-node build-rust build-esp-rs

publish: publish-base publish-node publish-rust publish-esp-rs

# Base

build-base:
  docker buildx build --platform linux/amd64,linux/arm64 --file templates/base/Dockerfile --tag kossnocorp/dev-base .

publish-base:
  docker push kossnocorp/dev-base

# Node.js

up-node:
  devcontainer build --workspace-folder workspaces/node
  devcontainer up --workspace-folder workspaces/node

build-node:
  docker buildx build --platform linux/amd64,linux/arm64 -t kossnocorp/dev-node templates/node

publish-node:
  docker push kossnocorp/dev-node

# Rust

build-rust:
  docker buildx build --platform linux/amd64,linux/arm64 -t kossnocorp/dev-rust templates/rust

publish-rust:
  docker push kossnocorp/dev-rust

# esp-rs

up-esp-rs:
  devcontainer build --workspace-folder workspaces/esp-rs
  devcontainer up --workspace-folder workspaces/esp-rs

build-esp-rs:
  docker buildx build --platform linux/amd64,linux/arm64 -t kossnocorp/dev-esp-rs templates/esp-rs

publish-esp-rs:
  docker push kossnocorp/dev-esp-rs

# Dev Containers

publish-templates:
  devcontainer templates publish -r ghcr.io -n kossnocorp/templates ./templates