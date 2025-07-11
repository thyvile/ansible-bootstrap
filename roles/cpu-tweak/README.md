# CPU-Tweak Role

This Ansible role provides CPU optimization functionality for server bootstrap operations, including C-state disabling and CPU governor configuration.

## Features

- CPU governor configuration (performance mode)
- C-state disabling for consistent performance
- Intel Hyper-Threading and AMD SMT detection
- Persistent configuration across reboots
- Multi-distribution support (Ubuntu, Debian, CentOS/RHEL)
- Detailed CPU information display

## Requirements

- Target system must have root/sudo access
- Python 3.x installed on target system
- CPU frequency scaling support (most modern systems)

## Role Variables

### Default Variables

```yaml
# CPU Governor settings
cpu_governor: "performance"              # CPU governor mode

# C-state settings
disable_cstates: true                    # Disable C-states for performance
disable_cstates_grub: false              # Add C-state disable to GRUB (requires reboot)
```

### Distribution-specific Packages

The role automatically installs required packages:

- **Ubuntu/Debian**: `cpufrequtils`, `linux-tools-generic`
- **CentOS/RHEL**: `cpupower`, `kernel-tools`

## Usage

### Include in Playbook

```yaml
- name: Optimize CPU performance
  include_role:
    name: cpu-tweak
  vars:
    cpu_governor: "performance"
    disable_cstates: true
```
