#!/bin/sh
set -e
KERNEL_VERSION="6.1.0"
KERNEL_SOURCE="https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${KERNEL_VERSION}.tar.xz"
BUILD_DIR="build-kernel"
if [ ! -d "$BUILD_DIR" ]; then
    mkdir "$BUILD_DIR"
fi
cd "$BUILD_DIR"
if [ ! -d "linux-${KERNEL_VERSION}" ]; then
    wget "$KERNEL_SOURCE"
    tar xf "linux-${KERNEL_VERSION}.tar.xz"
fi
cd "linux-${KERNEL_VERSION}"
make defconfig
make -j$(nproc) bzImage
cp arch/x86/boot/bzImage ../../../vmlinuz
cd ../../..
tar -czf kernel.tar.gz vmlinuz
rm -f vmlinuz