# All

build-all: build-base build-node build-rust

publish-all: publish-base publish-node publish-rust

# Base

build-base:
  docker buildx build --builder cloud-kossnocorp-mothership --platform linux/amd64 --file images/base/Dockerfile --tag kossnocorp/dev-base:amd64 .
  docker buildx build --builder cloud-kossnocorp-mothership --platform linux/arm64 --file images/base/Dockerfile --tag kossnocorp/dev-base:arm64 .

publish-base: build-base
  docker push kossnocorp/dev-base:amd64
  docker push kossnocorp/dev-base:arm64
  docker buildx imagetools create -t kossnocorp/dev-base:latest kossnocorp/dev-base:amd64 kossnocorp/dev-base:arm64

# Node.js

up-node:
  devcontainer build --workspace-folder workspaces/node
  devcontainer up --workspace-folder workspaces/node

build-node:
  docker buildx build --builder cloud-kossnocorp-mothership --platform linux/amd64 --file images/stack/Dockerfile --build-arg STACK=node --tag kossnocorp/dev-node:amd64 .
  docker buildx build --builder cloud-kossnocorp-mothership --platform linux/arm64 --file images/stack/Dockerfile --build-arg STACK=node --tag kossnocorp/dev-node:arm64 .

publish-node: build-node
  docker push kossnocorp/dev-node:amd64
  docker push kossnocorp/dev-node:arm64
  docker buildx imagetools create -t kossnocorp/dev-node:latest kossnocorp/dev-node:amd64 kossnocorp/dev-node:arm64

# Rust

up-rust:
  devcontainer build --workspace-folder workspaces/rust
  devcontainer up --workspace-folder workspaces/rust

build-rust:
  docker buildx build --builder cloud-kossnocorp-mothership --platform linux/amd64 --file images/stack/Dockerfile --build-arg STACK=rust --tag kossnocorp/dev-rust:amd64 .
  docker buildx build --builder cloud-kossnocorp-mothership --platform linux/arm64 --file images/stack/Dockerfile --build-arg STACK=rust --tag kossnocorp/dev-rust:arm64 .

publish-rust: build-rust
  docker push kossnocorp/dev-rust:amd64
  docker push kossnocorp/dev-rust:arm64
  docker buildx imagetools create -t kossnocorp/dev-rust:latest kossnocorp/dev-rust:amd64 kossnocorp/dev-rust:arm64

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
  # https://containers.dev/implementors/templates-distribution/
  devcontainer templates publish -r ghcr.io -n kossnocorp/templates ./templates