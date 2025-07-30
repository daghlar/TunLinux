all: iso

setup:
	./build-scripts/setup-base.sh

kernel:
	./build-scripts/minimal-kernel.sh

busybox:
	./build-scripts/busybox.sh

iso: setup kernel
	./build-scripts/iso.sh

test: iso
	./build-scripts/test.sh

clean:
	rm -rf build
	rm -rf iso
	rm -f tunlinux.iso
	rm -f tunlinux.tar.gz

install: iso
	./installer/install.sh --target $(TARGET)

.PHONY: all setup kernel busybox iso test clean install 