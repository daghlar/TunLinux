#!/bin/sh
set -e

echo "Creating minimal kernel setup..."

mkdir -p kernel

if [ -f /boot/vmlinuz-linux ]; then
    cp /boot/vmlinuz-linux kernel/vmlinuz
    echo "✓ Copied existing kernel"
elif [ -f /boot/vmlinuz ]; then
    cp /boot/vmlinuz kernel/vmlinuz
    echo "✓ Copied existing kernel"
else
    echo "Creating minimal kernel placeholder..."
    echo "kernel" > kernel/vmlinuz
    echo "✓ Created kernel placeholder"
fi

echo "Creating minimal initrd..."
mkdir -p initrd/{bin,dev,proc,sys,lib,etc,init}

cat > initrd/init << 'EOF'
#!/bin/sh
mount -t proc none /proc
mount -t sysfs none /sys
mount -t devtmpfs none /dev
exec /bin/sh
EOF

chmod +x initrd/init

cd initrd
find . -print0 | cpio -o -H newc -R root:root | gzip > ../kernel/initrd.img
cd ..

echo "✓ Minimal kernel setup complete" 