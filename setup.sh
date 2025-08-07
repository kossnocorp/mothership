# mise-en-place
curl https://mise.run | sh

# Install dependencies
eval "$(mise activate bash --shims)"
mise install --yes

# Run Ansible playbook
ansible-playbook playbooks/setup.yml --ask-become-pass