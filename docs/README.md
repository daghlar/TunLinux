# TunLinux

TunLinux is a minimal, customizable Linux distribution using runit or openrc as init system. It is designed for daily use and professional environments.

## Features

- Minimal Linux distribution
- Support for both OpenRC and Runit init systems
- Busybox-based userland
- Custom kernel configuration
- Easy build system
- Package management support

## Building

### Prerequisites

- Linux development tools (gcc, make, etc.)
- wget
- tar
- grub-mkrescue or xorriso

### Quick Build

```bash
make all
```

### Step by Step

```bash
make kernel      # Build kernel and initrd
make busybox     # Build busybox
make iso         # Create bootable ISO
```

### Clean Build

```bash
make clean
make all
```

## Installation

```bash
make install TARGET=/dev/sdX1
```

## Configuration

Edit `/etc/rc.conf` to configure:
- INIT_SYSTEM: openrc or runit
- AUTO_LOGIN: yes or no
- HOSTNAME: system hostname

## Package Management

```bash
./build-scripts/pkg.sh install <package>
./build-scripts/pkg.sh build <package>
```

## License

This project is open source. 