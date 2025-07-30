#!/bin/sh
set -e
BUSYBOX_VERSION="1.36.1"
BUSYBOX_SOURCE="https://busybox.net/downloads/busybox-${BUSYBOX_VERSION}.tar.bz2"
BUILD_DIR="build-busybox"
if [ ! -d "$BUILD_DIR" ]; then
    mkdir "$BUILD_DIR"
fi
cd "$BUILD_DIR"
if [ ! -d "busybox-${BUSYBOX_VERSION}" ]; then
    wget "$BUSYBOX_SOURCE"
    tar xf "busybox-${BUSYBOX_VERSION}.tar.bz2"
fi
cd "busybox-${BUSYBOX_VERSION}"
make defconfig
sed -i 's/# CONFIG_STATIC is not set/CONFIG_STATIC=y/' .config
make -j$(nproc)
cp busybox ../../busybox
cd ../..
tar -czf busybox.tar.gz busybox
rm -f busybox