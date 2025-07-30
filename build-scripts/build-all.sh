#!/bin/sh
set -e

echo "Building TunLinux..."
echo "===================="

echo "Step 1: Setting up base structure..."
./build-scripts/setup-base.sh

echo "Step 2: Creating minimal kernel..."
if [ ! -f kernel/vmlinuz ]; then
    ./build-scripts/minimal-kernel.sh
else
    echo "Kernel already exists, skipping..."
fi

echo "Step 3: Creating ISO..."
./build-scripts/iso.sh

echo "Step 4: Running tests..."
./build-scripts/test.sh

echo "===================="
echo "Build complete! ISO file: tunlinux.iso"
echo "You can now test the system with: ./build-scripts/test.sh" 