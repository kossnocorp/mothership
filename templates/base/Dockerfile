FROM mcr.microsoft.com/devcontainers/base:ubuntu24.04

# System
ENV DEBIAN_FRONTEND=noninteractive

# User
ENV USER="vscode"
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

# Install fish
COPY "$PLAYBOOKS/fish.yaml" "$PLAYBOOKS/fish.yaml"
RUN ansible-playbook "$PLAYBOOKS/fish.yaml" --inventory="$INVENTORY"

# Install Starship
COPY "$PLAYBOOKS/starship.yaml" "$PLAYBOOKS/starship.yaml"
RUN ansible-playbook "$PLAYBOOKS/starship.yaml" --inventory="$INVENTORY"

# Install chezmoi
COPY "$PLAYBOOKS/chezmoi.yaml" "$PLAYBOOKS/chezmoi.yaml"
RUN ansible-playbook "$PLAYBOOKS/chezmoi.yaml" --inventory="$INVENTORY"

# Install mise
COPY "$PLAYBOOKS/mise.yaml" "$PLAYBOOKS/mise.yaml"
RUN ansible-playbook "$PLAYBOOKS/mise.yaml" --inventory="$INVENTORY"

# Install Neovim
COPY "$PLAYBOOKS/neovim.yaml" "$PLAYBOOKS/neovim.yaml"
RUN ansible-playbook "$PLAYBOOKS/neovim.yaml" --inventory="$INVENTORY"