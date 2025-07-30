#!/bin/sh
set -e

ISO_DIR="iso"
KERNEL_DIR="kernel"
BOOT_DIR="boot"

echo "Creating ISO structure..."

rm -rf ${ISO_DIR}
mkdir -p ${ISO_DIR}/boot/grub
mkdir -p ${ISO_DIR}/kernel
mkdir -p ${ISO_DIR}/init
mkdir -p ${ISO_DIR}/usr
mkdir -p ${ISO_DIR}/etc
mkdir -p ${ISO_DIR}/bin
mkdir -p ${ISO_DIR}/lib
mkdir -p ${ISO_DIR}/var
mkdir -p ${ISO_DIR}/root
mkdir -p ${ISO_DIR}/home

if [ -f ${KERNEL_DIR}/vmlinuz ]; then
    echo "Copying kernel..."
    cp ${KERNEL_DIR}/vmlinuz ${ISO_DIR}/kernel/
else
    echo "Warning: Kernel not found, creating empty file"
    touch ${ISO_DIR}/kernel/vmlinuz
fi

if [ -f ${KERNEL_DIR}/initrd.img ]; then
    echo "Copying initrd..."
    cp ${KERNEL_DIR}/initrd.img ${ISO_DIR}/kernel/
else
    echo "Warning: Initrd not found, creating empty file"
    touch ${ISO_DIR}/kernel/initrd.img
fi

echo "Copying system files..."
cp -r ${BOOT_DIR}/grub/* ${ISO_DIR}/boot/grub/ 2>/dev/null || true
cp -r init/* ${ISO_DIR}/init/ 2>/dev/null || true
cp -r usr/* ${ISO_DIR}/usr/ 2>/dev/null || true
cp -r etc/* ${ISO_DIR}/etc/ 2>/dev/null || true
cp -r bin/* ${ISO_DIR}/bin/ 2>/dev/null || true
cp -r lib/* ${ISO_DIR}/lib/ 2>/dev/null || true
cp -r var/* ${ISO_DIR}/var/ 2>/dev/null || true
cp -r root/* ${ISO_DIR}/root/ 2>/dev/null || true
cp -r home/* ${ISO_DIR}/home/ 2>/dev/null || true

echo "Creating ISO..."

if command -v grub-mkrescue >/dev/null 2>&1; then
    grub-mkrescue -o tunlinux.iso ${ISO_DIR}
elif command -v xorriso >/dev/null 2>&1; then
    xorriso -as mkisofs -o tunlinux.iso -b boot/grub/i386-pc/eltorito.img -no-emul-boot -boot-load-size 4 -boot-info-table --grub2-boot-info --grub2-mbr /usr/lib/grub/i386-pc/boot_hybrid.img -r -V "TunLinux" -append-partition 2 0xef ${ISO_DIR}
else
    echo "Error: grub-mkrescue or xorriso not found"
    echo "Creating basic ISO structure only"
    tar -czf tunlinux.tar.gz ${ISO_DIR}
    echo "Created tunlinux.tar.gz instead"
    exit 1
fi

echo "ISO created: tunlinux.iso" 