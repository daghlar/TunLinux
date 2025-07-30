#!/bin/sh
set -e
mkdir -p build

# iproute2 (ip, ss, tc, vs.)
IPROUTE2_VERSION="6.7.0"
IPROUTE2_SOURCE="https://mirrors.edge.kernel.org/pub/linux/utils/net/iproute2/iproute2-${IPROUTE2_VERSION}.tar.xz"
cd build
if [ ! -d "iproute2-${IPROUTE2_VERSION}" ]; then
    wget "$IPROUTE2_SOURCE"
    tar xf "iproute2-${IPROUTE2_VERSION}.tar.xz"
fi
cd "iproute2-${IPROUTE2_VERSION}"
make
cp ip/ip ../../ip
cd ../..

# ping (inetutils)
INETUTILS_VERSION="2.4"
INETUTILS_SOURCE="https://ftp.gnu.org/gnu/inetutils/inetutils-${INETUTILS_VERSION}.tar.xz"
cd build
if [ ! -d "inetutils-${INETUTILS_VERSION}" ]; then
    wget "$INETUTILS_SOURCE"
    tar xf "inetutils-${INETUTILS_VERSION}.tar.xz"
fi
cd "inetutils-${INETUTILS_VERSION}"
./configure --disable-nls --disable-servers
make
cp ping/ping ../../ping
cd ../..

tar -czf network.tar.gz ip ping
rm -f ip ping
rm -rf build