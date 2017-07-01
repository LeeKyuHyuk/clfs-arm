#!/bin/bash
set -o nounset
set -o errexit

CONFIG_HOST=$(echo ${MACHTYPE} | sed -e 's/-[^-]*/-cross/')

function check {
  LIST_OF_SOURCES="
  autoconf-2.69.tar.xz
  automake-1.15.tar.xz
  binutils-2.28.tar.bz2
  bison-3.0.4.tar.xz
  fakeroot_1.20.2.orig.tar.bz2
  file-5.30.tar.gz
  flex-2.6.4.tar.gz
  gawk-4.1.4.tar.xz
  gcc-6.3.0.tar.bz2
  genext2fs-1.4.1.tar.gz
  gettext-0.19.8.1.tar.xz
  glib-2.52.0.tar.xz
  glibc-2.25.tar.xz
  gmp-6.1.2.tar.xz
  kmod-24.tar.xz
  libcap-2.25.tar.xz
  libffi-3.2.1.tar.gz
  libtool-2.4.6.tar.xz
  libxml2-2.9.4.tar.gz
  linux-4.11.7.tar.xz
  m4-1.4.18.tar.xz
  mpc-1.0.3.tar.gz
  mpfr-3.1.5.tar.xz
  ncurses-6.0.tar.gz
  pcre-8.40.tar.bz2
  pkgconf-0.9.12.tar.bz2
  util-linux-2.29.2.tar.xz
  zlib-1.2.11.tar.xz
  "
  for source in $LIST_OF_SOURCES ; do
    if ! [[ -f $SOURCES_DIR/$source ]] ; then
      $ERROR "Can't find $source!"
      exit 1
    fi
  done
}

function do_strip {
  set +o errexit
  if [[ $CONFIG_STRIP_AND_DELETE_DOCS = 1 ]] ; then
    strip --strip-debug $TOOLS_DIR/usr/lib/*
    /usr/bin/strip --strip-unneeded $TOOLS_DIR/usr/{,s}bin/*
    rm -rf $TOOLS_DIR/usr/{,share}/{info,man,doc}
  fi
}

check

$STEP "Create the Sysroot Directory"
install -dv -m 0755 $SYSROOT_DIR/usr/lib
install -dv -m 0755 $SYSROOT_DIR/usr/bin
install -dv -m 0755 $SYSROOT_DIR/usr/sbin
install -dv -m 0755 $SYSROOT_DIR/usr/include
ln -snvf usr/bin $SYSROOT_DIR/bin
ln -snvf usr/sbin $SYSROOT_DIR/sbin
ln -snvf usr/lib $SYSROOT_DIR/lib
ln -snvf lib $SYSROOT_DIR/lib32
ln -snvf lib $SYSROOT_DIR/usr/lib32

$STEP "file 5.30"
$EXTRACT $SOURCES_DIR/file-5.30.tar.gz $BUILD_DIR
( cd $BUILD_DIR/file-5.30 && ./configure --prefix=$TOOLS_DIR/usr )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/file-5.30
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/file-5.30
rm -rf $BUILD_DIR/file-5.30

$STEP "gawk 4.1.4"
$EXTRACT $SOURCES_DIR/gawk-4.1.4.tar.xz $BUILD_DIR
( cd $BUILD_DIR/gawk-4.1.4 && ./configure --prefix=$TOOLS_DIR/usr )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/gawk-4.1.4
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/gawk-4.1.4
rm -rf $BUILD_DIR/gawk-4.1.4

$STEP "m4 1.4.18"
$EXTRACT $SOURCES_DIR/m4-1.4.18.tar.xz $BUILD_DIR
( cd $BUILD_DIR/m4-1.4.18 && ./configure --prefix=$TOOLS_DIR/usr )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/m4-1.4.18
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/m4-1.4.18
rm -rf $BUILD_DIR/m4-1.4.18

$STEP "ncurses 6.0"
$EXTRACT $SOURCES_DIR/ncurses-6.0.tar.gz $BUILD_DIR
( cd $BUILD_DIR/ncurses-6.0 && \
AWK=gawk ./configure --prefix=$TOOLS_DIR/usr --without-debug )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/ncurses-6.0/include
make -j$CONFIG_PARALLEL_JOBS tic -C $BUILD_DIR/ncurses-6.0/progs
install -v -m755 $BUILD_DIR/ncurses-6.0/progs/tic $TOOLS_DIR/usr/bin
rm -rf $BUILD_DIR/ncurses-6.0

$STEP "binutils 2.28"
$EXTRACT $SOURCES_DIR/binutils-2.28.tar.bz2 $BUILD_DIR
mkdir -pv $BUILD_DIR/binutils-2.28/binutils-build
( cd $BUILD_DIR/binutils-2.28/binutils-build && \
AR="ar" \
AS="as" \
$BUILD_DIR/binutils-2.28/configure \
--prefix=$TOOLS_DIR/usr \
--sysconfdir=$TOOLS_DIR/etc \
--localstatedir=$TOOLS_DIR/var \
--disable-multilib \
--disable-werror \
--target=$CONFIG_TARGET \
--disable-shared \
--enable-static \
--with-sysroot=$SYSROOT_DIR \
--enable-poison-system-directories \
--disable-sim \
--disable-gdb )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/binutils-2.28/binutils-build
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/binutils-2.28/binutils-build
rm -rf $BUILD_DIR/binutils-2.28

$STEP "gcc 6.3.0 - initial"
tar -jxf $SOURCES_DIR/gcc-6.3.0.tar.bz2 -C $BUILD_DIR --exclude='libjava/*' --exclude='libgo/*' --exclude='gcc/testsuite/*' --exclude='libstdc++-v3/testsuite/*'
mkdir -p $BUILD_DIR/gcc-6.3.0/libstdc++-v3/testsuite/
echo "all:" > $BUILD_DIR/gcc-6.3.0/libstdc++-v3/testsuite/Makefile.in
echo "install:" >> $BUILD_DIR/gcc-6.3.0/libstdc++-v3/testsuite/Makefile.in
$EXTRACT $SOURCES_DIR/mpfr-3.1.5.tar.xz $BUILD_DIR/gcc-6.3.0
mv -v $BUILD_DIR/gcc-6.3.0/mpfr-3.1.5 $BUILD_DIR/gcc-6.3.0/mpfr
$EXTRACT $SOURCES_DIR/gmp-6.1.2.tar.xz $BUILD_DIR/gcc-6.3.0
mv -v $BUILD_DIR/gcc-6.3.0/gmp-6.1.2 $BUILD_DIR/gcc-6.3.0/gmp
$EXTRACT $SOURCES_DIR/mpc-1.0.3.tar.gz $BUILD_DIR/gcc-6.3.0
mv -v $BUILD_DIR/gcc-6.3.0/mpc-1.0.3 $BUILD_DIR/gcc-6.3.0/mpc
mkdir -v $BUILD_DIR/gcc-6.3.0/gcc-build
( cd $BUILD_DIR/gcc-6.3.0/gcc-build && \
AR="ar" \
LDFLAGS="-L$TOOLS_DIR/lib -L$TOOLS_DIR/usr/lib -Wl,-rpath,$TOOLS_DIR/usr/lib" \
$BUILD_DIR/gcc-6.3.0/configure \
--prefix=$TOOLS_DIR/usr \
--sysconfdir=$TOOLS_DIR/etc \
--localstatedir=$TOOLS_DIR/var \
--disable-static \
--target=$CONFIG_TARGET \
--with-sysroot=$SYSROOT_DIR \
--disable-__cxa_atexit \
--with-gnu-ld \
--disable-libssp \
--disable-multilib \
--with-pkgversion="$CONFIG_PKG_VERSION" \
--with-bugurl="$CONFIG_BUG_URL" \
--disable-libquadmath \
--enable-tls \
--disable-libmudflap \
--enable-threads \
--without-isl \
--without-cloog \
--disable-decimal-float \
--with-abi="$CONFIG_ABI" \
--with-cpu=$CONFIG_CPU \
--with-fpu=$CONFIG_FPU \
--with-float=$CONFIG_FLOAT \
--with-mode=$CONFIG_MODE \
--enable-languages=c \
--disable-shared \
--without-headers \
--disable-threads \
--with-newlib \
--disable-largefile \
--disable-nls )
make -j$CONFIG_PARALLEL_JOBS gcc_cv_libc_provides_ssp=yes all-gcc all-target-libgcc -C $BUILD_DIR/gcc-6.3.0/gcc-build
make -j$CONFIG_PARALLEL_JOBS install-gcc install-target-libgcc -C $BUILD_DIR/gcc-6.3.0/gcc-build
rm -rf $BUILD_DIR/gcc-6.3.0

$STEP "Linux 4.11.7 API Headers"
$EXTRACT $SOURCES_DIR/linux-4.11.7.tar.xz $BUILD_DIR
make mrproper -C $BUILD_DIR/linux-4.11.7
make -j$CONFIG_PARALLEL_JOBS ARCH=$CONFIG_MODE headers_check -C $BUILD_DIR/linux-4.11.7
make -j$CONFIG_PARALLEL_JOBS ARCH=$CONFIG_MODE INSTALL_HDR_PATH=$SYSROOT_DIR/usr headers_install -C $BUILD_DIR/linux-4.11.7
rm -rf $BUILD_DIR/linux-4.11.7

$STEP "glibc 2.25"
$EXTRACT $SOURCES_DIR/glibc-2.25.tar.xz $BUILD_DIR
mkdir -p $BUILD_DIR/glibc-2.25/glibc-build
( cd $BUILD_DIR/glibc-2.25/glibc-build && \
AR="$TOOLS_DIR/usr/bin/$CONFIG_TARGET-ar" \
CC="$TOOLS_DIR/usr/bin/$CONFIG_TARGET-gcc" \
RANLIB="$TOOLS_DIR/usr/bin/$CONFIG_TARGET-ranlib" \
BUILD_CC="gcc" \
$BUILD_DIR/glibc-2.25/configure \
libc_cv_forced_unwind=yes \
libc_cv_ssp=no \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--with-pkgversion="$CONFIG_PKG_VERSION" \
--prefix=/usr \
--enable-obsolete-rpc \
--enable-kernel=2.6.32 \
--with-headers=$SYSROOT_DIR/usr/include )
mkdir -p $SYSROOT_DIR/usr/include/gnu
touch $SYSROOT_DIR/usr/include/gnu/stubs.h
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/glibc-2.25/glibc-build
make -j$CONFIG_PARALLEL_JOBS install_root=$SYSROOT_DIR install -C $BUILD_DIR/glibc-2.25/glibc-build
echo "#include <gnu/stubs-hard.h>" > $SYSROOT_DIR/usr/include/gnu/stubs.h
ln -sv ld-2.25.so $SYSROOT_DIR/lib/ld-linux.so.3
rm -rf $BUILD_DIR/glibc-2.25

$STEP "gcc 6.3.0 - final"
tar -jxf $SOURCES_DIR/gcc-6.3.0.tar.bz2 -C $BUILD_DIR --exclude='libjava/*' --exclude='libgo/*' --exclude='gcc/testsuite/*' --exclude='libstdc++-v3/testsuite/*'
mkdir -p $BUILD_DIR/gcc-6.3.0/libstdc++-v3/testsuite/
echo "all:" > $BUILD_DIR/gcc-6.3.0/libstdc++-v3/testsuite/Makefile.in
echo "install:" >> $BUILD_DIR/gcc-6.3.0/libstdc++-v3/testsuite/Makefile.in
$EXTRACT $SOURCES_DIR/mpfr-3.1.5.tar.xz $BUILD_DIR/gcc-6.3.0
mv -v $BUILD_DIR/gcc-6.3.0/mpfr-3.1.5 $BUILD_DIR/gcc-6.3.0/mpfr
$EXTRACT $SOURCES_DIR/gmp-6.1.2.tar.xz $BUILD_DIR/gcc-6.3.0
mv -v $BUILD_DIR/gcc-6.3.0/gmp-6.1.2 $BUILD_DIR/gcc-6.3.0/gmp
$EXTRACT $SOURCES_DIR/mpc-1.0.3.tar.gz $BUILD_DIR/gcc-6.3.0
mv -v $BUILD_DIR/gcc-6.3.0/mpc-1.0.3 $BUILD_DIR/gcc-6.3.0/mpc
mkdir -v $BUILD_DIR/gcc-6.3.0/gcc-build
( cd $BUILD_DIR/gcc-6.3.0/gcc-build && \
AR="ar" \
LDFLAGS="-L$TOOLS_DIR/lib -L$TOOLS_DIR/usr/lib -Wl,-rpath,$TOOLS_DIR/usr/lib" \
$BUILD_DIR/gcc-6.3.0/configure \
--prefix=$TOOLS_DIR/usr \
--sysconfdir=$TOOLS_DIR/etc \
--enable-static \
--target=$CONFIG_TARGET \
--with-sysroot=$SYSROOT_DIR \
--disable-__cxa_atexit \
--with-gnu-ld \
--disable-libssp \
--disable-multilib \
--with-pkgversion="$CONFIG_PKG_VERSION" \
--with-bugurl="$CONFIG_BUG_URL" \
--disable-libquadmath \
--enable-tls \
--disable-libmudflap \
--enable-threads \
--without-isl \
--without-cloog \
--disable-decimal-float \
--with-abi="$CONFIG_ABI" \
--with-cpu=$CONFIG_CPU \
--with-fpu=$CONFIG_FPU \
--with-float=$CONFIG_FLOAT \
--with-mode=$CONFIG_MODE \
--enable-languages=c,c++ \
--with-build-time-tools=$TOOLS_DIR/usr/$CONFIG_TARGET/bin \
--enable-shared \
--disable-libgomp )
make -j$CONFIG_PARALLEL_JOBS AS_FOR_TARGET="$TOOLS_DIR/usr/bin/$CONFIG_TARGET-as" LD_FOR_TARGET="$TOOLS_DIR/usr/bin/$CONFIG_TARGET-ld" -C $BUILD_DIR/gcc-6.3.0/gcc-build
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/gcc-6.3.0/gcc-build
rm -rf $BUILD_DIR/gcc-6.3.0

$STEP "pkgconf 0.9.12"
$EXTRACT $SOURCES_DIR/pkgconf-0.9.12.tar.bz2 $BUILD_DIR
( cd $BUILD_DIR/pkgconf-0.9.12 && \
./configure \
--prefix=$TOOLS_DIR/usr \
--sysconfdir=$TOOLS_DIR/etc \
--localstatedir=$TOOLS_DIR/var \
--enable-shared \
--disable-static )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/pkgconf-0.9.12
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/pkgconf-0.9.12
install -v -m755 $SUPPORT_DIR/pkgconf/pkg-config $TOOLS_DIR/usr/bin/pkg-config
sed -i -e "s,@PKG_CONFIG_LIBDIR@,$SYSROOT_DIR/usr/lib/pkgconfig:$SYSROOT_DIR/usr/share/pkgconfig," -e "s,@STAGING_DIR@,$SYSROOT_DIR," $TOOLS_DIR/usr/bin/pkg-config
sed -i -e "s,@STATIC@,," $TOOLS_DIR/usr/bin/pkg-config
rm -rf $BUILD_DIR/pkgconf-0.9.12

$STEP "makedevs"
mkdir -p $BUILD_DIR/makedevs
gcc -O2 -I$TOOLS_DIR/usr/include $SUPPORT_DIR/makedevs/makedevs.c -o $BUILD_DIR/makedevs/makedevs -L$TOOLS_DIR/lib -L$TOOLS_DIR/usr/lib -Wl,-rpath,$TOOLS_DIR/usr/lib
install -Dv -m 755 $BUILD_DIR/makedevs/makedevs $TOOLS_DIR/usr/bin/makedevs
rm -rf $BUILD_DIR/makedevs

$STEP "mke2img"
install -Dv -m 0755 $SUPPORT_DIR/mke2img $TOOLS_DIR/usr/bin/mke2img

$STEP "genext2fs 1.4.1"
$EXTRACT $SOURCES_DIR/genext2fs-1.4.1.tar.gz $BUILD_DIR
( cd $BUILD_DIR/genext2fs-1.4.1 && \
PKG_CONFIG="$TOOLS_DIR/usr/bin/pkg-config" \
PKG_CONFIG_LIBDIR="$TOOLS_DIR/usr/lib/pkgconfig:$TOOLS_DIR/usr/share/pkgconfig" \
PKG_CONFIG_SYSROOT_DIR="/" \
PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
CPPFLAGS="-I$TOOLS_DIR/usr/include" \
CFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
LDFLAGS="-L$TOOLS_DIR/lib -L$TOOLS_DIR/usr/lib -Wl,-rpath,$TOOLS_DIR/usr/lib" \
./configure \
--prefix=$TOOLS_DIR/usr \
--sysconfdir=$TOOLS_DIR/etc \
--localstatedir=$TOOLS_DIR/var \
--enable-shared \
--disable-static )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/genext2fs-1.4.1
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/genext2fs-1.4.1
rm -rf $BUILD_DIR/genext2fs-1.4.1

$STEP "libcap 2.25"
$EXTRACT $SOURCES_DIR/libcap-2.25.tar.xz $BUILD_DIR
PKG_CONFIG="$TOOLS_DIR/usr/bin/pkg-config" PKG_CONFIG_LIBDIR="$TOOLS_DIR/usr/lib/pkgconfig:$TOOLS_DIR/usr/share/pkgconfig" PKG_CONFIG_SYSROOT_DIR="/" PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 make -j$CONFIG_PARALLEL_JOBS RAISE_SETFCAP=no -C $BUILD_DIR/libcap-2.25
PKG_CONFIG="$TOOLS_DIR/usr/bin/pkg-config" PKG_CONFIG_LIBDIR="$TOOLS_DIR/usr/lib/pkgconfig:$TOOLS_DIR/usr/share/pkgconfig" PKG_CONFIG_SYSROOT_DIR="/" PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 make -j$CONFIG_PARALLEL_JOBS DESTDIR=$TOOLS_DIR RAISE_SETFCAP=no prefix=/usr lib=lib install -C $BUILD_DIR/libcap-2.25
rm -rf $BUILD_DIR/libcap-2.25

$STEP "fakeroot 1.20.2"
$EXTRACT $SOURCES_DIR/fakeroot_1.20.2.orig.tar.bz2 $BUILD_DIR
( cd $BUILD_DIR/fakeroot-1.20.2 && \
PKG_CONFIG="$TOOLS_DIR/usr/bin/pkg-config" \
PKG_CONFIG_LIBDIR="$TOOLS_DIR/usr/lib/pkgconfig:$TOOLS_DIR/usr/share/pkgconfig" \
PKG_CONFIG_SYSROOT_DIR="/" \
PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
CPPFLAGS="-I$TOOLS_DIR/usr/include" \
CFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
LDFLAGS="-L$TOOLS_DIR/lib -L$TOOLS_DIR/usr/lib -Wl,-rpath,$TOOLS_DIR/usr/lib" \
./configure \
--prefix=$TOOLS_DIR/usr \
--sysconfdir=$TOOLS_DIR/etc \
--localstatedir=$TOOLS_DIR/var \
--enable-shared \
--disable-static )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/fakeroot-1.20.2
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/fakeroot-1.20.2
rm -rf $BUILD_DIR/fakeroot-1.20.2

$STEP "mkpasswd 5.0.26"
mkdir -p $BUILD_DIR/mkpasswd-5.0.26
gcc -O2 -I$TOOLS_DIR/usr/include -L$TOOLS_DIR/lib -L$TOOLS_DIR/usr/lib -Wl,-rpath,$TOOLS_DIR/usr/lib $SUPPORT_DIR/mkpasswd/mkpasswd.c $SUPPORT_DIR/mkpasswd/utils.c -o $BUILD_DIR/mkpasswd-5.0.26/mkpasswd -lcrypt
install -Dv -m 755 $BUILD_DIR/mkpasswd-5.0.26/mkpasswd $TOOLS_DIR/usr/bin/mkpasswd
rm -rf $BUILD_DIR/mkpasswd-5.0.26

$STEP "zlib 1.2.11"
$EXTRACT $SOURCES_DIR/zlib-1.2.11.tar.xz $BUILD_DIR
( cd $BUILD_DIR/zlib-1.2.11 && \
CFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
CPPFLAGS="-I$TOOLS_DIR/usr/include" \
CXXFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
LDFLAGS="-L$TOOLS_DIR/lib -L$TOOLS_DIR/usr/lib -Wl,-rpath,$TOOLS_DIR/usr/lib" \
PKG_CONFIG="$TOOLS_DIR/usr/bin/pkg-config" \
PKG_CONFIG_LIBDIR="$TOOLS_DIR/usr/lib/pkgconfig:$TOOLS_DIR/usr/share/pkgconfig" \
PKG_CONFIG_SYSROOT_DIR="/" \
PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
./configure \
--prefix=$TOOLS_DIR/usr \
--enable-shared )
make -j1 -C $BUILD_DIR/zlib-1.2.11
make -j1 LDCONFIG=true install -C $BUILD_DIR/zlib-1.2.11
rm -rf $BUILD_DIR/zlib-1.2.11

$STEP "libxml2 2.9.4"
$EXTRACT $SOURCES_DIR/libxml2-2.9.4.tar.gz $BUILD_DIR
( cd $BUILD_DIR/libxml2-2.9.4 && \
CFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
CPPFLAGS="-I$TOOLS_DIR/usr/include" \
CXXFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
LDFLAGS="-L$TOOLS_DIR/lib -L$TOOLS_DIR/usr/lib -Wl,-rpath,$TOOLS_DIR/usr/lib" \
PKG_CONFIG="$TOOLS_DIR/usr/bin/pkg-config" \
PKG_CONFIG_LIBDIR="$TOOLS_DIR/usr/lib/pkgconfig:$TOOLS_DIR/usr/share/pkgconfig" \
PKG_CONFIG_SYSROOT_DIR="/" \
PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
./configure \
--prefix=$TOOLS_DIR/usr \
--sysconfdir=$TOOLS_DIR/etc \
--localstatedir=$TOOLS_DIR/var \
--disable-static \
--without-zlib \
--without-lzma \
--without-python )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/libxml2-2.9.4
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/libxml2-2.9.4
rm -rf $BUILD_DIR/libxml2-2.9.4

$STEP "gettext 0.19.8.1"
$EXTRACT $SOURCES_DIR/gettext-0.19.8.1.tar.xz $BUILD_DIR
sed -i -e '/^SUBDIRS/s/ doc //;/^SUBDIRS/s/examples$$//' $BUILD_DIR/gettext-0.19.8.1/gettext-tools/Makefile.in
sed -i -e '/^SUBDIRS/s/ doc //;/^SUBDIRS/s/tests$$//' $BUILD_DIR/gettext-0.19.8.1/gettext-tools/Makefile.in
( cd $BUILD_DIR/gettext-0.19.8.1/gettext-tools && \
CFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
CPPFLAGS="-I$TOOLS_DIR/usr/include" \
CXXFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
LDFLAGS="-L$TOOLS_DIR/lib -L$TOOLS_DIR/usr/lib -Wl,-rpath,$TOOLS_DIR/usr/lib" \
PKG_CONFIG="$TOOLS_DIR/usr/bin/pkg-config" \
PKG_CONFIG_LIBDIR="$TOOLS_DIR/usr/lib/pkgconfig:$TOOLS_DIR/usr/share/pkgconfig" \
PKG_CONFIG_SYSROOT_DIR="/" \
PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
./configure \
--prefix=$TOOLS_DIR/usr \
--sysconfdir=$TOOLS_DIR/etc \
--localstatedir=$TOOLS_DIR/var \
--disable-static \
--disable-libasprintf \
--disable-acl \
--disable-openmp \
--disable-rpath \
--disable-java \
--disable-native-java \
--disable-csharp \
--disable-relocatable \
--without-emacs )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/gettext-0.19.8.1/gettext-tools
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/gettext-0.19.8.1/gettext-tools
rm -rf $BUILD_DIR/gettext-0.19.8.1

$STEP "libtool 2.4.6"
$EXTRACT $SOURCES_DIR/libtool-2.4.6.tar.xz $BUILD_DIR
find $BUILD_DIR/libtool-2.4.6 -name aclocal.m4 -exec touch '{}' \;
find $BUILD_DIR/libtool-2.4.6 -name config-h.in -exec touch '{}' \;
find $BUILD_DIR/libtool-2.4.6 -name configure -exec touch '{}' \;
find $BUILD_DIR/libtool-2.4.6 -name Makefile.in -exec touch '{}' \;
( cd $BUILD_DIR/libtool-2.4.6 && \
CFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
CPPFLAGS="-I$TOOLS_DIR/usr/include" \
CXXFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
LDFLAGS="-L$TOOLS_DIR/lib -L$TOOLS_DIR/usr/lib -Wl,-rpath,$TOOLS_DIR/usr/lib" \
PKG_CONFIG="$TOOLS_DIR/usr/bin/pkg-config" \
PKG_CONFIG_LIBDIR="$TOOLS_DIR/usr/lib/pkgconfig:$TOOLS_DIR/usr/share/pkgconfig" \
PKG_CONFIG_SYSROOT_DIR="/" \
PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
MAKEINFO=true \
./configure \
--prefix=$TOOLS_DIR/usr \
--sysconfdir=$TOOLS_DIR/etc \
--localstatedir=$TOOLS_DIR/var \
--disable-static )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/libtool-2.4.6
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/libtool-2.4.6
rm -rf $BUILD_DIR/libtool-2.4.6

$STEP "autoconf 2.69"
$EXTRACT $SOURCES_DIR/autoconf-2.69.tar.xz $BUILD_DIR
( cd $BUILD_DIR/autoconf-2.69 && \
CFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
CPPFLAGS="-I$TOOLS_DIR/usr/include" \
CXXFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
LDFLAGS="-L$TOOLS_DIR/lib -L$TOOLS_DIR/usr/lib -Wl,-rpath,$TOOLS_DIR/usr/lib" \
PKG_CONFIG="$TOOLS_DIR/usr/bin/pkg-config" \
PKG_CONFIG_LIBDIR="$TOOLS_DIR/usr/lib/pkgconfig:$TOOLS_DIR/usr/share/pkgconfig" \
PKG_CONFIG_SYSROOT_DIR="/" \
PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
EMACS="no" \
ac_cv_path_M4=$TOOLS_DIR/usr/bin/m4 \
ac_cv_prog_gnu_m4_gnu=no \
./configure \
--prefix=$TOOLS_DIR/usr \
--sysconfdir=$TOOLS_DIR/etc \
--localstatedir=$TOOLS_DIR/var )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/autoconf-2.69
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/autoconf-2.69
rm -rf $BUILD_DIR/autoconf-2.69

$STEP "automake 1.15"
$EXTRACT $SOURCES_DIR/automake-1.15.tar.xz $BUILD_DIR
( cd $BUILD_DIR/automake-1.15 && \
CFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
CPPFLAGS="-I$TOOLS_DIR/usr/include" \
CXXFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
LDFLAGS="-L$TOOLS_DIR/lib -L$TOOLS_DIR/usr/lib -Wl,-rpath,$TOOLS_DIR/usr/lib" \
PKG_CONFIG="$TOOLS_DIR/usr/bin/pkg-config" \
PKG_CONFIG_LIBDIR="$TOOLS_DIR/usr/lib/pkgconfig:$TOOLS_DIR/usr/share/pkgconfig" \
PKG_CONFIG_SYSROOT_DIR="/" \
PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
EMACS="no" \
ac_cv_path_M4=$TOOLS_DIR/usr/bin/m4 \
ac_cv_prog_gnu_m4_gnu=no \
./configure \
--prefix=$TOOLS_DIR/usr \
--sysconfdir=$TOOLS_DIR/etc \
--localstatedir=$TOOLS_DIR/var )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/automake-1.15
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/automake-1.15
install -D -m 0644 $SUPPORT_DIR/automake/gtk-doc.m4 $TOOLS_DIR/usr/share/aclocal/gtk-doc.m4
mkdir -p $SYSROOT_DIR/usr/share/aclocal
rm -rf $BUILD_DIR/automake-1.15

$STEP "flex 2.6.4"
$EXTRACT $SOURCES_DIR/flex-2.6.4.tar.gz $BUILD_DIR
( cd $BUILD_DIR/flex-2.6.4 && \
CFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
CPPFLAGS="-I$TOOLS_DIR/usr/include" \
CXXFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
LDFLAGS="-L$TOOLS_DIR/lib -L$TOOLS_DIR/usr/lib -Wl,-rpath,$TOOLS_DIR/usr/lib" \
PKG_CONFIG="$TOOLS_DIR/usr/bin/pkg-config" \
PKG_CONFIG_LIBDIR="$TOOLS_DIR/usr/lib/pkgconfig:$TOOLS_DIR/usr/share/pkgconfig" \
PKG_CONFIG_SYSROOT_DIR="/" \
PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
HELP2MAN=true \
./configure \
--prefix=$TOOLS_DIR/usr \
--sysconfdir=$TOOLS_DIR/etc \
--localstatedir=$TOOLS_DIR/var \
--enable-shared \
--disable-static )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/flex-2.6.4
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/flex-2.6.4
rm -rf $BUILD_DIR/flex-2.6.4

$STEP "bison 3.0.4"
$EXTRACT $SOURCES_DIR/bison-3.0.4.tar.xz $BUILD_DIR
( cd $BUILD_DIR/bison-3.0.4 && \
CFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
CPPFLAGS="-I$TOOLS_DIR/usr/include" \
CXXFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
LDFLAGS="-L$TOOLS_DIR/lib -L$TOOLS_DIR/usr/lib -Wl,-rpath,$TOOLS_DIR/usr/lib" \
PKG_CONFIG="$TOOLS_DIR/usr/bin/pkg-config" \
PKG_CONFIG_LIBDIR="$TOOLS_DIR/usr/lib/pkgconfig:$TOOLS_DIR/usr/share/pkgconfig" \
PKG_CONFIG_SYSROOT_DIR="/" \
PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
HELP2MAN=true \
./configure \
--prefix=$TOOLS_DIR/usr \
--sysconfdir=$TOOLS_DIR/etc \
--localstatedir=$TOOLS_DIR/var \
--enable-shared \
--disable-static )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/bison-3.0.4
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/bison-3.0.4
rm -rf $BUILD_DIR/bison-3.0.4

$STEP "libffi 3.2.1"
$EXTRACT $SOURCES_DIR/libffi-3.2.1.tar.gz $BUILD_DIR
sed -i -e 's/toolexeclib_LTLIBRARIES = libffi.la/lib_LTLIBRARIES = libffi.la/g' $BUILD_DIR/libffi-3.2.1/Makefile.am
( cd $BUILD_DIR/libffi-3.2.1 && \
CFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
CPPFLAGS="-I$TOOLS_DIR/usr/include" \
CXXFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
LDFLAGS="-L$TOOLS_DIR/lib -L$TOOLS_DIR/usr/lib -Wl,-rpath,$TOOLS_DIR/usr/lib" \
PKG_CONFIG="$TOOLS_DIR/usr/bin/pkg-config" \
PKG_CONFIG_LIBDIR="$TOOLS_DIR/usr/lib/pkgconfig:$TOOLS_DIR/usr/share/pkgconfig" \
PKG_CONFIG_SYSROOT_DIR="/" \
PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
./configure \
--prefix=$TOOLS_DIR/usr \
--sysconfdir=$TOOLS_DIR/etc \
--localstatedir=$TOOLS_DIR/var \
--enable-shared \
--disable-static )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/libffi-3.2.1
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/libffi-3.2.1
mv $TOOLS_DIR/usr/lib/libffi-3.2.1/include/*.h $TOOLS_DIR/usr/include/
sed -i -e '/^includedir.*/d' -e '/^Cflags:.*/d' $TOOLS_DIR/usr/lib/pkgconfig/libffi.pc
rm -rf $TOOLS_DIR/usr/lib/libffi-*
rm -rf $BUILD_DIR/libffi-3.2.1

$STEP "pcre 8.40"
$EXTRACT $SOURCES_DIR/pcre-8.40.tar.bz2 $BUILD_DIR
( cd $BUILD_DIR/pcre-8.40 && \
CFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
CPPFLAGS="-I$TOOLS_DIR/usr/include" \
CXXFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
LDFLAGS="-L$TOOLS_DIR/lib -L$TOOLS_DIR/usr/lib -Wl,-rpath,$TOOLS_DIR/usr/lib" \
PKG_CONFIG="$TOOLS_DIR/usr/bin/pkg-config" \
PKG_CONFIG_LIBDIR="$TOOLS_DIR/usr/lib/pkgconfig:$TOOLS_DIR/usr/share/pkgconfig" \
PKG_CONFIG_SYSROOT_DIR="/" \
PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
./configure \
--prefix=$TOOLS_DIR/usr \
--sysconfdir=$TOOLS_DIR/etc \
--localstatedir=$TOOLS_DIR/var \
--enable-shared \
--disable-static \
--enable-unicode-properties )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/pcre-8.40
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/pcre-8.40
rm -rf $BUILD_DIR/pcre-8.40

$STEP "util-linux 2.29.2"
$EXTRACT $SOURCES_DIR/util-linux-2.29.2.tar.xz $BUILD_DIR
( cd $BUILD_DIR/util-linux-2.29.2 && \
CFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
CPPFLAGS="-I$TOOLS_DIR/usr/include" \
CXXFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
LDFLAGS="-L$TOOLS_DIR/lib -L$TOOLS_DIR/usr/lib -Wl,-rpath,$TOOLS_DIR/usr/lib" \
PKG_CONFIG="$TOOLS_DIR/usr/bin/pkg-config" \
PKG_CONFIG_LIBDIR="$TOOLS_DIR/usr/lib/pkgconfig:$TOOLS_DIR/usr/share/pkgconfig" \
PKG_CONFIG_SYSROOT_DIR="/" \
PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
./configure \
--prefix=$TOOLS_DIR/usr \
--sysconfdir=$TOOLS_DIR/etc \
--localstatedir=$TOOLS_DIR/var \
--enable-shared \
--disable-static \
--without-python \
--enable-libblkid \
--enable-libmount \
--enable-libuuid \
--without-ncurses \
--without-tinfo \
--disable-all-programs )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/util-linux-2.29.2
make -j$CONFIG_PARALLEL_JOBS install MKINSTALLDIRS=$BUILD_DIR/util-linux-2.29.2/config/mkinstalldirs -C $BUILD_DIR/util-linux-2.29.2
rm -rf $BUILD_DIR/util-linux-2.29.2

$STEP "glib 2.52.0"
$EXTRACT $SOURCES_DIR/glib-2.52.0.tar.xz $BUILD_DIR
sed -i -e "s# tests##" $BUILD_DIR/glib-2.52.0/Makefile.am
sed -i -e "s# tests##" $BUILD_DIR/glib-2.52.0/gio/Makefile.am
sed -i -e "s# tests##" $BUILD_DIR/glib-2.52.0/glib/Makefile.am
patch -Np0 -i $SUPPORT_DIR/glib/glib-2.52.0-as_fn_error.patch -d $BUILD_DIR/glib-2.52.0
( cd $BUILD_DIR/glib-2.52.0 && \
LIBS="-lpcre -lffi" \
CFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
CPPFLAGS="-I$TOOLS_DIR/usr/include" \
CXXFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
LDFLAGS="-L$TOOLS_DIR/lib -L$TOOLS_DIR/usr/lib -Wl,-rpath,$TOOLS_DIR/usr/lib" \
PCRE_CFLAGS="-I$TOOLS_DIR/usr/include" \
ZLIB_CFLAGS="-I$TOOLS_DIR/usr/include" \
LIBMOUNT_CFLAGS="-I$TOOLS_DIR/usr/include" \
LIBFFI_CFLAGS="-I$TOOLS_DIR/usr/include" \
PKG_CONFIG="$TOOLS_DIR/usr/bin/pkg-config" \
PKG_CONFIG_LIBDIR="$TOOLS_DIR/usr/lib/pkgconfig:$TOOLS_DIR/usr/share/pkgconfig" \
PKG_CONFIG_SYSROOT_DIR="/" \
PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
./configure \
--prefix=$TOOLS_DIR/usr \
--sysconfdir=$TOOLS_DIR/etc \
--localstatedir=$TOOLS_DIR/var \
--enable-shared \
--disable-static \
--disable-coverage \
--disable-dtrace \
--disable-fam \
--disable-libelf \
--disable-selinux \
--disable-systemtap \
--disable-xattr \
--with-pcre=system )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/glib-2.52.0
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/glib-2.52.0
rm -rf $BUILD_DIR/glib-2.52.0

$STEP "kmod 24"
$EXTRACT $SOURCES_DIR/kmod-24.tar.xz $BUILD_DIR
( cd $BUILD_DIR/kmod-24 && \
CFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
CPPFLAGS="-I$TOOLS_DIR/usr/include" \
CXXFLAGS="-O2 -I$TOOLS_DIR/usr/include" \
LDFLAGS="-L$TOOLS_DIR/lib -L$TOOLS_DIR/usr/lib -Wl,-rpath,$TOOLS_DIR/usr/lib" \
PKG_CONFIG="$TOOLS_DIR/usr/bin/pkg-config" \
PKG_CONFIG_LIBDIR="$TOOLS_DIR/usr/lib/pkgconfig:$TOOLS_DIR/usr/share/pkgconfig" \
./configure \
--prefix=$TOOLS_DIR/usr \
--sysconfdir=$TOOLS_DIR/etc \
--localstatedir=$TOOLS_DIR/var \
--disable-manpages )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/kmod-24
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/kmod-24
mkdir -p $TOOLS_DIR/sbin/
ln -sf ../usr/bin/kmod $TOOLS_DIR/sbin/depmod
rm -rf $BUILD_DIR/kmod-24

do_strip
