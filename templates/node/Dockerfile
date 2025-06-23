FROM kossnocorp/dev-base:latest

# Stack and tools
COPY mise.toml "$HOME/.config/mise/mise.toml"
RUN sudo chown "$USER:$USER" "$HOME/.config/mise/mise.toml"
RUN eval "$(mise activate bash --shims)" \
        && mise install
