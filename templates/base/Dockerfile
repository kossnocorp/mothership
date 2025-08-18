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
COPY "$PLAYBOOKS/local-bin-tasks.yaml" "$PLAYBOOKS/local-bin-tasks.yaml"

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

# Install age
COPY "$PLAYBOOKS/age.yaml" "$PLAYBOOKS/age.yaml"
RUN ansible-playbook "$PLAYBOOKS/age.yaml" --inventory="$INVENTORY"

# Install SOPS
COPY "$PLAYBOOKS/sops.yaml" "$PLAYBOOKS/sops.yaml"
RUN ansible-playbook "$PLAYBOOKS/sops.yaml" --inventory="$INVENTORY"
