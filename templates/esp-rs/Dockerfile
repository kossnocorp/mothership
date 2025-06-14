FROM mcr.microsoft.com/devcontainers/base:ubuntu

# User

ENV USER="vscode"
USER "$USER"
ENV HOME="/home/$USER"

# Env

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="$HOME/.local/bin:$PATH"

# System

RUN sudo apt-get update

# Fish
RUN sudo apt-get install -y fish \
        && mkdir -p "$HOME/.config/fish/completions"

# mise-en-place
RUN curl https://mise.run | sh \
        && echo "if status is-interactive\n  mise activate fish | source\nelse\n  mise activate fish --shims | source\nend\n" >> ~/.config/fish/config.fish \
        && PATH="$HOME/.local/bin:$PATH" \
        && mise use -g usage \
        && mise completion fish > ~/.config/fish/completions/mise.fish

# Deps
RUN sudo apt-get install -y neovim

# Stack and tools
RUN mkdir -p "$HOME/.config/mise"
COPY mise.toml "$HOME/.config/mise/mise.toml"
RUN sudo chown "$USER:$USER" "$HOME/.config/mise/mise.toml"
RUN eval "$(mise activate bash --shims)" \
        && mise install

# Espressif deps
RUN sudo apt-get install -y llvm-dev libclang-dev clang libudev-dev libuv1-dev pkgconf python3-venv python-is-python3

# Embedded tools
RUN sudo apt-get install -y usbutils
