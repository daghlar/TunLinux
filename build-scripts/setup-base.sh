#!/bin/sh
set -e

echo "Setting up base system structure..."

mkdir -p {bin,dev,proc,sys,tmp,run,var/{log,lock,cache,tmp}}
mkdir -p usr/{bin,sbin,lib,lib64,share,local}
mkdir -p lib lib64
mkdir -p etc/{skel,network,init.d}
mkdir -p root home
mkdir -p var/service

chmod 755 bin dev proc sys tmp run
chmod 755 usr usr/bin usr/sbin usr/lib usr/lib64
chmod 755 lib lib64
chmod 755 etc root home
chmod 755 var/service

echo "Base system structure created" 