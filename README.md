# Server Bootstrap - Ansible Project

This Ansible project provides automated Linux server preparation with security and performance optimizations. It includes three main roles for comprehensive server bootstrapping:

## What It Does

This project automates the complete bootstrap process for Linux servers with three core components:

- **encrypt**: LUKS disk/partition encryption for data-at-rest security
- **net-rename**: Network interface renaming to consistent 'net0' naming
- **cpu-tweak**: CPU optimization including C-state disabling and performance governor tweaks

## Features

- **LUKS Disk Encryption**: Secure encryption for secondary disks/partitions
- **CPU Optimization**: C-state disabling and performance governor configuration
- **Network Interface Renaming**: Consistent interface naming (net0)
- **System Information Display**: Detailed CPU and multithreading information
- **Idempotent Operations**: Safe to run multiple times

## Quick Start

### 1. Install Dependencies

```bash
# Install Python dependencies
make install

# Install Ansible Galaxy collections
make install-galaxy

# Run the playbook with tags needed
ansible-playbook -i inventory/local-vm/hosts.yml system-bootstrap.yml --tags encrypt,net-rename,cpu-tweak --ask-become-pass --ask-vault-pass
```

### 2. Configure Inventory

Edit `inventory/local-vm/hosts.yml` or add your own:

```yaml
all:
  hosts:
    server1:
      ansible_host: 192.168.1.100 # IP address of server
      ansible_user: ubuntu # login
      ansible_ssh_private_key_file: ~/.ssh/my-key # SSH private key for connection
      # Required: specify partition OR disk to encrypt
      encrypt_disk: /dev/sdb
      # encrypt_partition: /dev/sdb1
      encrypted_partition_path: /part # name of the partition to mount after LUKS encryption - mandatory parameter

      # Extra vars for "encrypt" tag - values below are set as defaults
      luks_cipher: "aes-xts-plain64"
      luks_key_size: "256"
      luks_hash: "sha256"
      luks_name: "encrypted_disk"
      luks_filesystem: "ext4"
```

### 3. Roles Overview

### Encrypt Role

Provides LUKS disk encryption for secondary storage:

- **Purpose**: Secure data at rest
- **Target**: Secondary disks/partitions (not root)
- **Features**: LUKS encryption, automatic mounting, configurable parameters
- **Requirements**: Unmounted target, root access

**Key Variables**:
```yaml
encrypt_partition: "/dev/sdb1"      # OR encrypt_disk: "/dev/sdb"
encrypted_partition_path: "/part"   # Mount point after encryption
luks_passphrase: "SecurePass123!"   # Use vault in production
```

### CPU-Tweak Role

Optimizes CPU performance for server workloads if launched against a baremetal machine:

- **Purpose**: Consistent high performance
- **Features**: C-state disabling, performance governor, HT/SMT detection
- **Benefits**: Reduced latency, predictable performance
- **Impact**: Higher power consumption

**Key Variables**:
```yaml
cpu_governor: "performance"
disable_cstates: true
```

### Net-Rename Role

Renames network interfaces for consistency:

- **Purpose**: Predictable interface naming
- **Target**: Active network interface → net0
- **Method**: udev rules based on MAC address
- **Persistence**: Survives reboots and kernel updates

### Complete Bootstrap

```bash
# With both privilege escalation and vault prompts
ansible-playbook -i inventory/local-vm/hosts.yml system-bootstrap.yml --ask-become-pass --ask-vault-pass
```

### Individual Components

```bash
# Disk encryption only
make encrypt
ansible-playbook -i inventory/local-vm/hosts.yml system-bootstrap.yml --tags encrypt --ask-become-pass --ask-vault-pass

# CPU optimization only  
make cpu
ansible-playbook -i inventory/local-vm/hosts.yml system-bootstrap.yml --tags cpu-tweak --ask-become-pass --ask-vault-pass

# Network renaming only
make network
ansible-playbook -i inventory/local-vm/hosts.yml system-bootstrap.yml --tags net-rename --ask-become-pass --ask-vault-pass
```
