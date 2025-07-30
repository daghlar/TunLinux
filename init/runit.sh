#!/bin/sh

export PATH=/usr/bin:/usr/sbin:/bin:/sbin

if [ -f /etc/environment ]; then
    . /etc/environment
fi

if [ -f /etc/profile ]; then
    . /etc/profile
fi

if [ -f /etc/rc.conf ]; then
    . /etc/rc.conf
fi

mkdir -p /var/service
mkdir -p /var/log

if [ -x /usr/bin/runsvdir ]; then
    exec /usr/bin/runsvdir /var/service
else
    if [ "$AUTO_LOGIN" = "yes" ]; then
        exec /bin/login -f root
    else
        exec /bin/getty 38400 tty1
    fi
fi 