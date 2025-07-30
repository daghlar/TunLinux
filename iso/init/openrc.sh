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

if [ "$AUTO_LOGIN" = "yes" ]; then
    exec /bin/login -f root
else
    exec /bin/getty 38400 tty1
fi 