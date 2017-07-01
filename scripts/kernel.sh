#!/bin/bash
set -o nounset
set -o errexit

export CC=$TOOLS_DIR/usr/bin/$CONFIG_TARGET-gcc
export CXX=$TOOLS_DIR/usr/bin/$CONFIG_TARGET-g++
export AR=$TOOLS_DIR/usr/bin/$CONFIG_TARGET-ar
export AS=$TOOLS_DIR/usr/bin/$CONFIG_TARGET-as
export LD=$TOOLS_DIR/usr/bin/$CONFIG_TARGET-ld
export RANLIB=$TOOLS_DIR/usr/bin/$CONFIG_TARGET-ranlib
export READELF=$TOOLS_DIR/usr/bin/$CONFIG_TARGET-readelf
export STRIP=$TOOLS_DIR/usr/bin/$CONFIG_TARGET-strip

function check {
  LIST_OF_SOURCES="
  linux-4.11.7.tar.xz
  "
  for source in $LIST_OF_SOURCES ; do
    if ! [[ -f $SOURCES_DIR/$source ]] ; then
      $ERROR "Can't find $source!"
      exit 1
    fi
  done
}

check

$STEP "Linux 4.11.7 Kernel"
$EXTRACT $SOURCES_DIR/linux-4.11.7.tar.xz $BUILD_DIR
make mrproper -C $BUILD_DIR/linux-4.11.7
make ARCH=$CONFIG_MODE vexpress_defconfig -C $BUILD_DIR/linux-4.11.7
make ARCH=$CONFIG_MODE vexpress_defconfig -C $BUILD_DIR/linux-4.11.7
BR_BINARIES_DIR=$IMAGES_DIR /usr/bin/make -j$CONFIG_PARALLEL_JOBS HOSTCC="gcc" HOSTCFLAGS="" ARCH=$CONFIG_MODE INSTALL_MOD_PATH=$ROOTFS_DIR CROSS_COMPILE="$TOOLS_DIR/usr/bin/$CONFIG_TARGET-" DEPMOD=$TOOLS_DIR/sbin/depmod INSTALL_MOD_STRIP=1 -C $BUILD_DIR/linux-4.11.7 zImage
BR_BINARIES_DIR=$IMAGES_DIR /usr/bin/make -j$CONFIG_PARALLEL_JOBS HOSTCC="gcc" HOSTCFLAGS="" ARCH=$CONFIG_MODE INSTALL_MOD_PATH=$ROOTFS_DIR CROSS_COMPILE="$TOOLS_DIR/usr/bin/$CONFIG_TARGET-" DEPMOD=$TOOLS_DIR/sbin/depmod INSTALL_MOD_STRIP=1 -C $BUILD_DIR/linux-4.11.7 vexpress-v2p-ca9.dtb
install -m 0644 -D $BUILD_DIR/linux-4.11.7/arch/arm/boot/zImage $KERNEL_DIR/zImage
cp -v $BUILD_DIR/linux-4.11.7/arch/arm/boot/dts/vexpress-v2p-ca9.dtb $KERNEL_DIR
rm -rf $BUILD_DIR/linux-4.11.7
