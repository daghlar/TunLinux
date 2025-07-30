#!/bin/sh
set -e
tar -xzf kernel.tar.gz
install -m 755 vmlinuz /kernel/vmlinuz
rm -f vmlinuz