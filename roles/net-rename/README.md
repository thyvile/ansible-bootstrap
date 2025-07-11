# Net-Rename Role

This Ansible role provides network interface renaming functionality for server bootstrap operations, renaming the active network interface to 'net0'.

## Features

- Automatic detection of active network interface
- Rename active interface to 'net0' using udev rules
- Support for multiple network configuration systems
- Persistent configuration across reboots
- Multi-distribution support (Ubuntu, Debian, CentOS/RHEL)
- Detailed interface information display

## Requirements

- Target system must have root/sudo access
- Python 3.x installed on target system
- Active network interface with default route
- SSH access must be maintained during configuration

## Role Variables

### Default Variables

```yaml
# Network interface renaming settings
target_interface_name: "net0"

# Configuration paths
udev_rule_file: "/etc/udev/rules.d/70-persistent-net.rules"
netplan_config_path: "/etc/netplan/"
network_interfaces_path: "/etc/network/interfaces"
```

## Usage

### Include in Playbook

```yaml
- name: Rename network interface
  include_role:
    name: net-rename
```
