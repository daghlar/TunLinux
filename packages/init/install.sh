#!/bin/sh
set -e
tar -xzf init.tar.gz
install -m 755 init.sh /init/init.sh
install -m 755 openrc.sh /init/openrc.sh
install -m 755 runit.sh /init/runit.sh
rm -f init.sh openrc.sh runit.sh