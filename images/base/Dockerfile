FROM mcr.microsoft.com/devcontainers/base:ubuntu24.04

# Base

# Vars
ENV DEBIAN_FRONTEND=noninteractive
ENV USER="vscode"
ENV HOME="/home/$USER"

# User
USER "$USER"

# Install Ansible
COPY ./setup/scripts/ansible.sh /tmp/ansible.sh
RUN sudo chmod +x /tmp/ansible.sh \
  && /tmp/ansible.sh

# Playbooks

# Consts
ENV PLAYBOOKS="./setup/playbooks"
ENV INVENTORY="/tmp/inventory.ini"

# Inventory
COPY "$PLAYBOOKS/inventory.ini" "$INVENTORY"

# Shared playbooks
COPY "$PLAYBOOKS/local-bin-tasks.yaml" "/tmp/local-bin-tasks.yaml"

# Install fish
COPY "$PLAYBOOKS/fish.yaml" "/tmp/fish.yaml"
RUN ansible-playbook "/tmp/fish.yaml" --inventory="$INVENTORY"

# Install Starship
COPY "$PLAYBOOKS/starship.yaml" "/tmp/starship.yaml"
RUN ansible-playbook "/tmp/starship.yaml" --inventory="$INVENTORY"

# Install chezmoi
COPY "$PLAYBOOKS/chezmoi.yaml" "/tmp/chezmoi.yaml"
RUN ansible-playbook "/tmp/chezmoi.yaml" --inventory="$INVENTORY"

# Install mise
COPY "$PLAYBOOKS/mise.yaml" "/tmp/mise.yaml"
RUN ansible-playbook "/tmp/mise.yaml" --inventory="$INVENTORY"

# Install Neovim
COPY "$PLAYBOOKS/neovim.yaml" "/tmp/neovim.yaml"
RUN ansible-playbook "/tmp/neovim.yaml" --inventory="$INVENTORY"

# Install age
COPY "$PLAYBOOKS/age.yaml" "$PLAYBOOKS/age.yaml"
RUN ansible-playbook "$PLAYBOOKS/age.yaml" --inventory="$INVENTORY"

# Install SOPS
COPY "$PLAYBOOKS/sops.yaml" "$PLAYBOOKS/sops.yaml"
RUN ansible-playbook "$PLAYBOOKS/sops.yaml" --inventory="$INVENTORY"

# Install stack & tools
COPY ./setup/configs/base/mise.toml "$HOME/.config/mise/mise.toml"
COPY ./setup/scripts/mise-config.sh /tmp/mise-config.sh
RUN sudo chmod +x /tmp/mise-config.sh \
  && /tmp/mise-config.sh