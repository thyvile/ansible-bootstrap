# Ansible Bootstrap Makefile
# This provides convenient shortcuts for common operations

# Default inventory
INVENTORY ?= inventory/local-vm/hosts.yml
PLAYBOOK ?= system-bootstrap.yml

# Default target
.DEFAULT_GOAL := help

# Help target
help:
	@echo "Available targets:"
	@echo "  install         - Install Python dependencies"
	@echo "  install-galaxy  - Install Ansible Galaxy requirements"
	@echo "  syntax          - Check playbook syntax"

# Install Python dependencies
install:
	pip install -r requirements.txt

# Install Ansible Galaxy requirements
install-galaxy:
	ansible-galaxy install -r requirements.yml

# Check syntax
syntax:
	ansible-playbook -i $(INVENTORY) $(PLAYBOOK) --syntax-check
