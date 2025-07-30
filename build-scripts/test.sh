#!/bin/sh
set -e

echo "Running TunLinux tests..."
echo "========================"

test_count=0
passed_count=0

test_file() {
    local file="$1"
    local description="$2"
    test_count=$((test_count + 1))
    
    if [ -f "$file" ]; then
        echo "✓ $description"
        passed_count=$((passed_count + 1))
        return 0
    else
        echo "✗ $description"
        return 1
    fi
}

test_dir() {
    local dir="$1"
    local description="$2"
    test_count=$((test_count + 1))
    
    if [ -d "$dir" ]; then
        echo "✓ $description"
        passed_count=$((passed_count + 1))
        return 0
    else
        echo "✗ $description"
        return 1
    fi
}

test_executable() {
    local file="$1"
    local description="$2"
    test_count=$((test_count + 1))
    
    if [ -x "$file" ]; then
        echo "✓ $description"
        passed_count=$((passed_count + 1))
        return 0
    else
        echo "✗ $description"
        return 1
    fi
}

test_file "kernel/vmlinuz" "Kernel file"
test_file "kernel/initrd.img" "Initrd file"
test_executable "init/init.sh" "Init script"
test_executable "init/openrc.sh" "OpenRC script"
test_executable "init/runit.sh" "Runit script"
test_file "etc/rc.conf" "RC configuration"
test_file "etc/passwd" "User database"
test_file "etc/group" "Group database"
test_file "etc/fstab" "Filesystem table"
test_file "boot/grub/grub.cfg" "GRUB configuration"
test_dir "usr/bin" "User binaries directory"
test_dir "usr/sbin" "System binaries directory"
test_dir "var/service" "Service directory"
test_dir "bin" "System binaries directory"
test_dir "lib" "System libraries directory"
test_dir "etc" "Configuration directory"
test_dir "boot/grub" "GRUB directory"

echo "========================"
echo "Tests completed: $passed_count/$test_count passed"

if [ $passed_count -eq $test_count ]; then
    echo "All tests passed! System is ready."
    exit 0
else
    echo "Some tests failed. Please check the build process."
    echo "Note: Kernel and busybox need to be built separately."
    exit 1
fi 