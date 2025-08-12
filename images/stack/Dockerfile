FROM kossnocorp/dev-base:latest

# Check STACK
ARG STACK
RUN test -n "$STACK" || (echo "🛑 STACK build argument is required" && exit 1)

# Install stack & tools
COPY ./setup/configs/${STACK}/mise.toml "$HOME/.config/mise/mise.toml"
COPY ./setup/scripts/mise-config.sh /tmp/mise-config.sh
RUN sudo chmod +x /tmp/mise-config.sh \
  && /tmp/mise-config.sh