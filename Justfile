up-esp-rs:
  devcontainer build --workspace-folder workspaces/esp-rs
  devcontainer up --workspace-folder workspaces/esp-rs

build-esp-rs:
  docker build -t kossnocorp/esp-rs templates/esp-rs

publish-esp-rs:
  docker push kossnocorp/esp-rs

publish-templates:
  devcontainer templates publish -r ghcr.io -n kossnocorp/templates ./templates