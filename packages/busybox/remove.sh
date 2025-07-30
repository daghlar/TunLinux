#!/bin/sh
set -e
cd /bin
if [ -f busybox ]; then
    for cmd in $(./busybox --list); do
        rm -f $cmd
    done
    rm -f busybox
fi