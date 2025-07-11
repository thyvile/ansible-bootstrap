# Encrypt Role

This Ansible role provides LUKS disk encryption functionality for server bootstrap operations.

## Features

- LUKS encryption for partitions or entire disks
- Support for both partition and disk encryption
- Configurable encryption parameters (cipher, key size, hash)
- Automatic filesystem creation and mounting
- Idempotent operations (safe to run multiple times)
- Multi-distribution support (Ubuntu, Debian, CentOS/RHEL)

## Requirements

- Target system must have root/sudo access
- Python 3.x installed on target system
- `cryptsetup` package (automatically installed by role)
- Target partition/disk must exist and be unmounted

## Role Variables

### Required Variables

Either `encrypt_partition` or `encrypt_disk` must be defined in inventory:

```yaml
# For partition encryption
encrypt_partition: "/dev/sdb1"

# OR for entire disk encryption
encrypt_disk: "/dev/sdb"

# Mandatory mount point variable
encrypted_partition_path: "/part"
```

### Optional Variables

```yaml
# LUKS encryption settings
luks_passphrase: "Passphrase123!"           # Passphrase - NEEDS TO BE SET
luks_cipher: "aes-xts-plain64"              # Encryption cipher
luks_key_size: "256"                        # Key size in bits
luks_hash: "sha256"                         # Hash algorithm
luks_iter_time: "2000"                      # Iteration time in ms
luks_name: "encrypted_disk"                 # LUKS container name
luks_filesystem: "ext4"                     # Filesystem type
```

## Usage

### Include in Playbook

```yaml
- name: Setup disk encryption
  include_role:
    name: encrypt
  vars:
    encrypt_partition: "/dev/sdb1"
    luks_passphrase: "{{ luks_passphrase }}" # use ansible-vault for extra security
```
