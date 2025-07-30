#!/bin/sh

mount -t proc none /proc
mount -t sysfs none /sys
mount -t devtmpfs none /dev

mkdir -p /dev/pts
mount -t devpts none /dev/pts

hostname tunlinux

if [ -f /etc/rc.conf ]; then
    . /etc/rc.conf
fi

if [ "$INIT_SYSTEM" = "runit" ]; then
    exec /init/runit.sh
else
    exec /init/openrc.sh
fi 