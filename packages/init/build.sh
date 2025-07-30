#!/bin/sh
set -e
mkdir -p build
cp ../../init/init.sh build/init.sh
cp ../../init/openrc.sh build/openrc.sh
cp ../../init/runit.sh build/runit.sh
tar -czf init.tar.gz -C build init.sh openrc.sh runit.sh
rm -rf build