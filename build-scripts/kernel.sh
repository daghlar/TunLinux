#!/bin/sh
set -e

KERNEL_VERSION="6.1.0"
KERNEL_SOURCE="https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${KERNEL_VERSION}.tar.xz"
BUILD_DIR="$(pwd)/build"
KERNEL_DIR="${BUILD_DIR}/linux-${KERNEL_VERSION}"

./build-scripts/setup-base.sh

mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}

if [ ! -d "linux-${KERNEL_VERSION}" ]; then
    echo "Downloading kernel source..."
    wget ${KERNEL_SOURCE}
    tar xf linux-${KERNEL_VERSION}.tar.xz
fi

cd linux-${KERNEL_VERSION}

echo "Configuring kernel..."
make defconfig

echo "Building kernel..."
make -j$(nproc) bzImage

echo "Building modules..."
make modules

echo "Installing modules..."
make modules_install INSTALL_MOD_PATH=${BUILD_DIR}/rootfs

echo "Copying kernel..."
cp arch/x86/boot/bzImage ../../kernel/vmlinuz

echo "Creating initrd..."
cd ${BUILD_DIR}
mkdir -p rootfs/{bin,dev,proc,sys,lib,lib64,usr,etc,init}
cp -a /lib/modules/${KERNEL_VERSION} rootfs/lib/modules/ 2>/dev/null || true

cd rootfs
find . -print0 | cpio -o -H newc -R root:root | gzip > ../../kernel/initrd.img

echo "Kernel build complete!" 