#!/bin/sh
set -e

TARGET_DIR="/mnt/tunlinux"

install_system() {
    local target="$1"
    
    echo "Installing TunLinux to $target..."
    
    mkdir -p "$target"
    mount "$target" "$target"
    
    cp -r /usr "$target/"
    cp -r /etc "$target/"
    cp -r /init "$target/"
    cp -r /kernel "$target/"
    cp -r /boot "$target/"
    
    mkdir -p "$target"/{proc,sys,dev,var,home,root}
    
    echo "Installation complete!"
    echo "Don't forget to install GRUB bootloader"
}

case "$1" in
    --target)
        install_system "$2"
        ;;
    *)
        echo "Usage: $0 --target <device>"
        echo "Example: $0 --target /dev/sda1"
        exit 1
        ;;
esac 