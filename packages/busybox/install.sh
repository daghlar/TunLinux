#!/bin/sh
set -e
tar -xzf busybox.tar.gz
install -m 755 busybox /bin/busybox
cd /bin
for cmd in $(./busybox --list); do
    ln -sf busybox $cmd
done
rm -f busybox