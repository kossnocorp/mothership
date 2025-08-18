# All

build-all: build-base build-node build-rust build-go

publish-all: publish-base publish-node publish-rust publish-go

# Base

build-base:
  docker buildx build --builder cloud-kossnocorp-mothership --platform linux/amd64 --file images/base/Dockerfile --tag kossnocorp/dev-base:amd64 --push .
  docker buildx build --builder cloud-kossnocorp-mothership --platform linux/arm64 --file images/base/Dockerfile --tag kossnocorp/dev-base:arm64 --push .

publish-base: build-base
  docker buildx imagetools create --tag kossnocorp/dev-base:latest kossnocorp/dev-base:amd64 kossnocorp/dev-base:arm64

# Node.js

up-node:
  devcontainer build --workspace-folder workspaces/node
  devcontainer up --workspace-folder workspaces/node

build-node:
  docker buildx build --builder cloud-kossnocorp-mothership --platform linux/amd64 --file images/stack/Dockerfile --build-arg STACK=node --tag kossnocorp/dev-node:amd64 --push .
  docker buildx build --builder cloud-kossnocorp-mothership --platform linux/arm64 --file images/stack/Dockerfile --build-arg STACK=node --tag kossnocorp/dev-node:arm64 --push .

publish-node: build-node
  docker buildx imagetools create --tag kossnocorp/dev-node:latest kossnocorp/dev-node:amd64 kossnocorp/dev-node:arm64

# Rust

up-rust:
  devcontainer build --workspace-folder workspaces/rust
  devcontainer up --workspace-folder workspaces/rust

build-rust:
  docker buildx build --builder cloud-kossnocorp-mothership --platform linux/amd64 --file images/stack/Dockerfile --build-arg STACK=rust --tag kossnocorp/dev-rust:amd64 --push .
  docker buildx build --builder cloud-kossnocorp-mothership --platform linux/arm64 --file images/stack/Dockerfile --build-arg STACK=rust --tag kossnocorp/dev-rust:arm64 --push .

publish-rust: build-rust
  docker buildx imagetools create --tag kossnocorp/dev-rust:latest kossnocorp/dev-rust:amd64 kossnocorp/dev-rust:arm64

# Go

build-go:
  docker buildx build --builder cloud-kossnocorp-mothership --platform linux/amd64 --file images/stack/Dockerfile --build-arg STACK=go --tag kossnocorp/dev-go:amd64 --push .
  docker buildx build --builder cloud-kossnocorp-mothership --platform linux/arm64 --file images/stack/Dockerfile --build-arg STACK=go --tag kossnocorp/dev-go:arm64 --push .

publish-go: build-go
  docker buildx imagetools create --tag kossnocorp/dev-go:latest kossnocorp/dev-go:amd64 kossnocorp/dev-go:arm64

# esp-rs

up-esp-rs:
  devcontainer build --workspace-folder workspaces/esp-rs
  devcontainer up --workspace-folder workspaces/esp-rs

build-esp-rs:
  docker buildx build --platform linux/amd64,linux/arm64 -t kossnocorp/dev-esp-rs templates/esp-rs

push-esp-rs:
  docker push kossnocorp/dev-esp-rs

# Dev Containers

publish-templates:
  devcontainer templates publish -r ghcr.io -n kossnocorp/templates ./templates