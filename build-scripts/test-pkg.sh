#!/bin/sh
set -e
echo "Testing package manager..."
usr/bin/tunpkg install hello
/usr/bin/hello
usr/bin/tunpkg remove hello
echo "Package manager test complete."