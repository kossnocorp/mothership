FROM kossnocorp/dev-base:latest

# Check STACK
ARG STACK
RUN test -n "$STACK" || (echo "🛑 STACK build argument is required" && exit 1)

# Install stack & tools
COPY --chown=${USER}:${USER} ./setup/configs/${STACK}/mise.toml "$HOME/.config/mise/mise.toml"
COPY ./setup/scripts/mise-config.sh /tmp/mise-config.sh
RUN sudo chmod +x /tmp/mise-config.sh \
  && /tmp/mise-config.sh

# Create the stack file to identify for update scripts
RUN mkdir -p "$HOME/.config/mothership" \
  && echo "$STACK" > "$HOME/.config/mothership/stack"

# Copy runtime scripts
COPY --chown=${USER}:${USER} ./runtime/stack/* /usr/local/bin/
RUN chmod +x /usr/local/bin/*