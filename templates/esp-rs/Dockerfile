FROM mcr.microsoft.com/devcontainers/base:ubuntu

# User

USER vscode
ENV HOME="/home/vscode"

# Env

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="$HOME/.local/bin:$PATH"

# Fish
RUN sudo apt-get update \
        && sudo apt-get install -y fish \
        && mkdir -p "$HOME/.config/fish/completions"

# mise-en-place
RUN curl https://mise.run | sh \
        && echo "if status is-interactive\n  mise activate fish | source\nelse\n  mise activate fish --shims | source\nend\n" >> ~/.config/fish/config.fish \
        && PATH="$HOME/.local/bin:$PATH" \
        && mise use -g usage \
        && mise completion fish > ~/.config/fish/completions/mise.fish

# Ubuntu deps
RUN sudo apt-get update \
        && sudo apt-get install -y neovim

# mise-controlled deps
RUN mkdir -p "$HOME/.config/mise"
COPY mise.toml "$HOME/.config/mise/mise.toml"
RUN eval "$(mise activate bash --shims)" \
        && mise install
