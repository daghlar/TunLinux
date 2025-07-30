#!/bin/sh

PKG_DIR="$(pwd)/packages"
INSTALL_DIR="$(pwd)/usr"

pkg_install() {
    local pkg="$1"
    local pkg_file="${PKG_DIR}/${pkg}.tar.gz"
    
    if [ ! -f "$pkg_file" ]; then
        echo "Package $pkg not found"
        return 1
    fi
    
    echo "Installing $pkg..."
    tar -xzf "$pkg_file" -C "$INSTALL_DIR"
    echo "$pkg installed successfully"
}

pkg_build() {
    local pkg="$1"
    local src_dir="${PKG_DIR}/sources/${pkg}"
    
    if [ ! -d "$src_dir" ]; then
        echo "Source directory for $pkg not found"
        return 1
    fi
    
    echo "Building $pkg..."
    cd "$src_dir"
    ./build.sh
    cd - > /dev/null
    
    echo "$pkg built successfully"
}

case "$1" in
    install)
        pkg_install "$2"
        ;;
    build)
        pkg_build "$2"
        ;;
    *)
        echo "Usage: $0 {install|build} <package>"
        exit 1
        ;;
esac 