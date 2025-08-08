FROM kossnocorp/dev-base:latest

# Check STACK
ARG STACK
RUN test -n "$STACK" || (echo "🛑 STACK build argument is required" && exit 1)

# Install stack & tools
COPY templates/${STACK}/mise.toml "$HOME/.config/mise/mise.toml"
COPY ./setup/scripts/stack.sh /tmp/stack.sh
RUN sudo chmod +x /tmp/stack.sh \
  && /tmp/stack.sh