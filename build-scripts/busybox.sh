#!/bin/sh
set -e

BUSYBOX_VERSION="1.36.1"
BUSYBOX_SOURCE="https://busybox.net/downloads/busybox-${BUSYBOX_VERSION}.tar.bz2"
BUILD_DIR="$(pwd)/build"
BUSYBOX_DIR="${BUILD_DIR}/busybox-${BUSYBOX_VERSION}"

./build-scripts/setup-base.sh

mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}

if [ ! -d "busybox-${BUSYBOX_VERSION}" ]; then
    wget ${BUSYBOX_SOURCE}
    tar xf busybox-${BUSYBOX_VERSION}.tar.bz2
fi

cd busybox-${BUSYBOX_VERSION}

make defconfig
sed -i 's/# CONFIG_STATIC is not set/CONFIG_STATIC=y/' .config
sed -i 's/# CONFIG_FEATURE_INSTALLER is not set/CONFIG_FEATURE_INSTALLER=y/' .config
make -j$(nproc)
make install

mkdir -p ../../bin
mkdir -p ../../usr/bin
mkdir -p ../../usr/sbin

cp busybox ../../bin/
cp busybox ../../usr/bin/
cp busybox ../../usr/sbin/

cd ../../bin
ln -sf busybox sh
ln -sf busybox ash
ln -sf busybox bash

cd ../usr/bin
for cmd in $(./busybox --list); do
    ln -sf busybox $cmd
done

cd ../usr/sbin
for cmd in $(./busybox --list); do
    ln -sf busybox $cmd
done 