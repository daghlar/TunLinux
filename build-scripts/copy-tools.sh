#!/bin/sh
set -e

echo "Copying essential system tools..."

mkdir -p bin usr/bin usr/sbin lib lib64

if command -v bash >/dev/null 2>&1; then
    cp $(which bash) bin/
    ln -sf bash bin/sh
    echo "✓ Bash copied"
fi

if command -v busybox >/dev/null 2>&1; then
    cp $(which busybox) bin/
    cp $(which busybox) usr/bin/
    echo "✓ Busybox copied"
fi

if command -v ls >/dev/null 2>&1; then
    cp $(which ls) bin/ 2>/dev/null || true
    echo "✓ Basic tools copied"
fi

if command -v mount >/dev/null 2>&1; then
    cp $(which mount) bin/ 2>/dev/null || true
    echo "✓ Mount copied"
fi

if command -v umount >/dev/null 2>&1; then
    cp $(which umount) bin/ 2>/dev/null || true
    echo "✓ Umount copied"
fi

echo "Essential tools copied" 