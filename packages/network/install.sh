#!/bin/sh
set -e
tar -xzf network.tar.gz
install -m 755 ip /usr/bin/ip
install -m 755 ping /usr/bin/ping
rm -f ip ping