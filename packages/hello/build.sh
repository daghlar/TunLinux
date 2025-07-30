#!/bin/sh
set -e
mkdir -p build
echo 'echo Hello, TunLinux!' > build/hello
chmod +x build/hello
tar -czf hello.tar.gz -C build hello