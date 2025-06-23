FROM kossnocorp/dev-base:latest

# Espressif deps
RUN sudo apt-get update \
  && sudo apt-get install -y llvm-dev libclang-dev clang libudev-dev libuv1-dev pkgconf python3-venv python-is-python3

# Embedded tools
RUN sudo apt-get update \
  && sudo apt-get install -y usbutils

# Stack and tools
COPY mise.toml "$HOME/.config/mise/mise.toml"
RUN sudo chown "$USER:$USER" "$HOME/.config/mise/mise.toml"
RUN eval "$(mise activate bash --shims)" \
  && mise install
