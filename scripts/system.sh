#!/bin/bash
set -o nounset
set -o errexit

CONFIG_HOST=$(echo ${MACHTYPE} | sed -e 's/-[^-]*/-cross/')

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
  autoconf-2.69.tar.xz
  automake-1.15.tar.xz
  bash-4.4.tar.gz
  bc-1.06.95.tar.bz2
  binutils-2.28.tar.bz2
  bison-3.0.4.tar.xz
  bzip2-1.0.6.tar.gz
  coreutils-8.27.tar.xz
  diffutils-3.5.tar.xz
  e2fsprogs-1.43.4.tar.gz
  eudev-3.2.1.tar.gz
  file-5.30.tar.gz
  findutils-4.6.0.tar.gz
  flex-2.6.4.tar.gz
  gawk-4.1.4.tar.xz
  gcc-6.3.0.tar.bz2
  gdbm-1.13.tar.gz
  gettext-0.19.8.1.tar.xz
  glib-2.52.0.tar.xz
  glibc-2.25.tar.xz
  gmp-6.1.2.tar.xz
  gperf-3.0.4.tar.gz
  grep-3.0.tar.xz
  gzip-1.8.tar.xz
  iana-etc-2.30.tar.bz2
  inetutils-1.9.4.tar.xz
  iproute2-4.10.0.tar.xz
  kbd-2.0.4.tar.xz
  kmod-24.tar.xz
  less-487.tar.gz
  libcap-2.25.tar.xz
  libffi-3.2.1.tar.gz
  libpipeline-1.4.1.tar.gz
  libtool-2.4.6.tar.xz
  linux-4.11.7.tar.xz
  m4-1.4.18.tar.xz
  make-4.2.1.tar.bz2
  man-pages-4.10.tar.xz
  mpc-1.0.3.tar.gz
  mpfr-3.1.5.tar.xz
  ncurses-6.0.tar.gz
  ntp-4.2.8p9.tar.gz
  openssh-7.4p1.tar.gz
  openssl-1.0.2k.tar.gz
  patch-2.7.5.tar.xz
  pcre-8.40.tar.bz2
  pkg-config-0.29.2.tar.gz
  procps-ng-3.3.12.tar.xz
  psmisc-22.21.tar.gz
  readline-7.0.tar.gz
  sed-4.4.tar.xz
  shadow-4.4.tar.xz
  sysklogd-1.5.1.tar.gz
  sysvinit-2.88dsf.tar.bz2
  tar-1.29.tar.xz
  texinfo-6.3.tar.xz
  tzdata2017b.tar.gz
  util-linux-2.29.2.tar.xz
  vim-8.0.069.tar.bz2
  xz-5.2.3.tar.xz
  zlib-1.2.11.tar.xz
  "
  for source in $LIST_OF_SOURCES ; do
    if ! [[ -f $SOURCES_DIR/$source ]] ; then
      $ERROR "Can't find $source!"
      exit 1
    fi
  done
}

check

$STEP "Linux 4.11.7 API Headers"
$EXTRACT $SOURCES_DIR/linux-4.11.7.tar.xz $BUILD_DIR
mkdir -p $BUILD_DIR/linux-4.11.7/dest
make mrproper -C $BUILD_DIR/linux-4.11.7
make -j$CONFIG_PARALLEL_JOBS ARCH=$CONFIG_MODE headers_check -C $BUILD_DIR/linux-4.11.7
make -j$CONFIG_PARALLEL_JOBS ARCH=$CONFIG_MODE INSTALL_HDR_PATH=$BUILD_DIR/linux-4.11.7/dest headers_install -C $BUILD_DIR/linux-4.11.7
find $BUILD_DIR/linux-4.11.7/dest/include \( -name .install -o -name ..install.cmd \) -delete
cp -rv $BUILD_DIR/linux-4.11.7/dest/include/* $ROOTFS_DIR/usr/include
rm -rf $BUILD_DIR/linux-4.11.7

$STEP "man pages 4.10"
$EXTRACT $SOURCES_DIR/man-pages-4.10.tar.xz $BUILD_DIR
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/man-pages-4.10
rm -rf $BUILD_DIR/man-pages-4.10

$STEP "zlib 1.2.11"
$EXTRACT $SOURCES_DIR/zlib-1.2.11.tar.xz $BUILD_DIR
( cd $BUILD_DIR/zlib-1.2.11 && ./configure --prefix=/usr )
make -j1 -C $BUILD_DIR/zlib-1.2.11
make -j1 LDCONFIG=true DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/zlib-1.2.11
rm -rf $BUILD_DIR/zlib-1.2.11

$STEP "file 5.30"
$EXTRACT $SOURCES_DIR/file-5.30.tar.gz $BUILD_DIR
( cd $BUILD_DIR/file-5.30 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/file-5.30
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/file-5.30
rm -rf $BUILD_DIR/file-5.30

$STEP "ncurses 6.0"
$EXTRACT $SOURCES_DIR/ncurses-6.0.tar.gz $BUILD_DIR
sed -i '/LIBTOOL_INSTALL/d' $BUILD_DIR/ncurses-6.0/c++/Makefile.in
( cd $BUILD_DIR/ncurses-6.0 && \
CPPFLAGS="-P" \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--mandir=/usr/share/man \
--with-shared \
--without-debug \
--without-normal \
--enable-pc-files \
--enable-widec )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/ncurses-6.0
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR PKG_CONFIG_LIBDIR=/usr/lib/pkgconfig install -C $BUILD_DIR/ncurses-6.0
for lib in ncurses form panel menu ; do
  rm -vf                    $ROOTFS_DIR/usr/lib/lib${lib}.so
  echo "INPUT(-l${lib}w)" > $ROOTFS_DIR/usr/lib/lib${lib}.so
  ln -sfv ${lib}w.pc        $ROOTFS_DIR/usr/lib/pkgconfig/${lib}.pc
done
rm -vf                     $ROOTFS_DIR/usr/lib/libcursesw.so
echo "INPUT(-lncursesw)" > $ROOTFS_DIR/usr/lib/libcursesw.so
ln -sfv libncurses.so      $ROOTFS_DIR/usr/lib/libcurses.so
rm -rf $BUILD_DIR/ncurses-6.0

$STEP "readline 7.0"
$EXTRACT $SOURCES_DIR/readline-7.0.tar.gz $BUILD_DIR
sed -i '/MV.*old/d' $BUILD_DIR/readline-7.0/Makefile.in
sed -i '/{OLDSUFF}/c:' $BUILD_DIR/readline-7.0/support/shlib-install
( cd $BUILD_DIR/readline-7.0 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--disable-static \
--docdir=/usr/share/doc/readline-7.0 )
make -j$CONFIG_PARALLEL_JOBS SHLIB_LIBS="-lncursesw" -C $BUILD_DIR/readline-7.0
make -j$CONFIG_PARALLEL_JOBS SHLIB_LIBS="-lncurses" DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/readline-7.0
mv -v $ROOTFS_DIR/usr/lib/libreadline.so.* $ROOTFS_DIR/lib
mv -v $ROOTFS_DIR/usr/lib/libhistory.so.* $ROOTFS_DIR/lib
ln -sfv ../../lib/$(readlink $ROOTFS_DIR/usr/lib/libreadline.so) $ROOTFS_DIR/usr/lib/libreadline.so
ln -sfv ../../lib/$(readlink $ROOTFS_DIR/usr/lib/libhistory.so) $ROOTFS_DIR/usr/lib/libhistory.so
rm -rf $BUILD_DIR/readline-7.0

$STEP "m4 1.4.18"
$EXTRACT $SOURCES_DIR/m4-1.4.18.tar.xz $BUILD_DIR
( cd $BUILD_DIR/m4-1.4.18 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/m4-1.4.18
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/m4-1.4.18
rm -rf $BUILD_DIR/m4-1.4.18

$STEP "bc 1.06.95"
$EXTRACT $SOURCES_DIR/bc-1.06.95.tar.bz2 $BUILD_DIR
patch -Np1 -i $SUPPORT_DIR/bc/array_initialize.patch -d $BUILD_DIR/bc-1.06.95
patch -Np1 -i $SUPPORT_DIR/bc/notice_read_write_errors.patch -d $BUILD_DIR/bc-1.06.95
patch -Np1 -i $SUPPORT_DIR/bc/use_appropiate_makeinfo.patch -d $BUILD_DIR/bc-1.06.95
( cd $BUILD_DIR/bc-1.06.95 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--with-readline \
--mandir=/usr/share/man \
--infodir=/usr/share/info )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/bc-1.06.95
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/bc-1.06.95
rm -rf $BUILD_DIR/bc-1.06.95

$STEP "binutils 2.28"
$EXTRACT $SOURCES_DIR/binutils-2.28.tar.bz2 $BUILD_DIR
mkdir -pv $BUILD_DIR/binutils-2.28/binutils-build
( cd $BUILD_DIR/binutils-2.28/binutils-build && \
$BUILD_DIR/binutils-2.28/configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--enable-gold \
--enable-ld=default \
--enable-plugins \
--enable-shared \
--disable-werror \
--with-system-zlib )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/binutils-2.28/binutils-build
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/binutils-2.28/binutils-build
rm -rf $BUILD_DIR/binutils-2.28

$STEP "gcc 6.3.0"
$EXTRACT $SOURCES_DIR/gcc-6.3.0.tar.bz2 $BUILD_DIR
$EXTRACT $SOURCES_DIR/mpfr-3.1.5.tar.xz $BUILD_DIR/gcc-6.3.0
mv -v $BUILD_DIR/gcc-6.3.0/mpfr-3.1.5 $BUILD_DIR/gcc-6.3.0/mpfr
$EXTRACT $SOURCES_DIR/gmp-6.1.2.tar.xz $BUILD_DIR/gcc-6.3.0
mv -v $BUILD_DIR/gcc-6.3.0/gmp-6.1.2 $BUILD_DIR/gcc-6.3.0/gmp
$EXTRACT $SOURCES_DIR/mpc-1.0.3.tar.gz $BUILD_DIR/gcc-6.3.0
mv -v $BUILD_DIR/gcc-6.3.0/mpc-1.0.3 $BUILD_DIR/gcc-6.3.0/mpc
mkdir -v $BUILD_DIR/gcc-6.3.0/gcc-build
( cd $BUILD_DIR/gcc-6.3.0/gcc-build && \
$BUILD_DIR/gcc-6.3.0/configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--disable-decimal-float \
--with-abi="$CONFIG_ABI" \
--with-cpu=$CONFIG_CPU \
--with-fpu=$CONFIG_FPU \
--with-float=$CONFIG_FLOAT \
--with-mode=$CONFIG_MODE \
--enable-languages=c,c++ \
--disable-multilib \
--disable-bootstrap \
--with-system-zlib )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/gcc-6.3.0/gcc-build
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/gcc-6.3.0/gcc-build
ln -svf ../usr/bin/cpp $ROOTFS_DIR/lib
ln -svf gcc $ROOTFS_DIR/usr/bin/cc
mkdir -pv $ROOTFS_DIR/usr/share/gdb/auto-load/usr/lib
mv -v $ROOTFS_DIR/usr/lib/*gdb.py $ROOTFS_DIR/usr/share/gdb/auto-load/usr/lib
rm -rf $BUILD_DIR/gcc-6.3.0

$STEP "Bzip2 1.0.6"
$EXTRACT $SOURCES_DIR/bzip2-1.0.6.tar.gz $BUILD_DIR
patch -Np1 -i $SUPPORT_DIR/bzip2/bzip2-1.0.6-install_docs-1.patch -d $BUILD_DIR/bzip2-1.0.6
sed -i 's#\(ln -s -f \)$(PREFIX)/bin/#\1#' $BUILD_DIR/bzip2-1.0.6/Makefile
sed -i "s#(PREFIX)/share/man#(PREFIX)/share/man#g" $BUILD_DIR/bzip2-1.0.6/Makefile
sed -i "s#bzip2recover test#bzip2recover#g" $BUILD_DIR/bzip2-1.0.6/Makefile
make -j$CONFIG_PARALLEL_JOBS CC=$TOOLS_DIR/usr/bin/$CONFIG_TARGET-gcc AR=$TOOLS_DIR/usr/bin/$CONFIG_TARGET-ar RANLIB=$TOOLS_DIR/usr/bin/$CONFIG_TARGET-ranlib -C $BUILD_DIR/bzip2-1.0.6 -f Makefile-libbz2_so
make clean -C $BUILD_DIR/bzip2-1.0.6
make -j$CONFIG_PARALLEL_JOBS CC=$TOOLS_DIR/usr/bin/$CONFIG_TARGET-gcc AR=$TOOLS_DIR/usr/bin/$CONFIG_TARGET-ar RANLIB=$TOOLS_DIR/usr/bin/$CONFIG_TARGET-ranlib -C $BUILD_DIR/bzip2-1.0.6
make -j$CONFIG_PARALLEL_JOBS CC=$TOOLS_DIR/usr/bin/$CONFIG_TARGET-gcc AR=$TOOLS_DIR/usr/bin/$CONFIG_TARGET-ar RANLIB=$TOOLS_DIR/usr/bin/$CONFIG_TARGET-ranlib PREFIX=$ROOTFS_DIR/usr install -C $BUILD_DIR/bzip2-1.0.6
cp -v $BUILD_DIR/bzip2-1.0.6/bzip2-shared $ROOTFS_DIR/bin/bzip2
cp -av $BUILD_DIR/bzip2-1.0.6/libbz2.so* $ROOTFS_DIR/lib
ln -sfv ../../lib/libbz2.so.1.0 $ROOTFS_DIR/usr/lib/libbz2.so
rm -v $ROOTFS_DIR/usr/bin/{bunzip2,bzcat,bzip2}
ln -sfv bzip2 $ROOTFS_DIR/bin/bunzip2
ln -sfv bzip2 $ROOTFS_DIR/bin/bzcat
rm -rf $BUILD_DIR/bzip2-1.0.6

$STEP "libffi 3.2.1"
$EXTRACT $SOURCES_DIR/libffi-3.2.1.tar.gz $BUILD_DIR
( cd $BUILD_DIR/libffi-3.2.1 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--disable-static )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/libffi-3.2.1
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/libffi-3.2.1
mv $ROOTFS_DIR/usr/lib/libffi-3.2.1/include/*.h $ROOTFS_DIR/usr/include/
sed -i -e '/^includedir.*/d' -e '/^Cflags:.*/d' $ROOTFS_DIR/usr/lib/pkgconfig/libffi.pc
rm -rf $BUILD_DIR/libffi-3.2.1

$STEP "pcre 8.40"
$EXTRACT $SOURCES_DIR/pcre-8.40.tar.bz2 $BUILD_DIR
( cd $BUILD_DIR/pcre-8.40 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=$ROOTFS_DIR/usr \
--disable-static \
--enable-shared \
--enable-pcre8 \
--disable-pcre16 \
--disable-pcre32 \
--enable-utf \
--enable-unicode-properties )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/pcre-8.40
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/pcre-8.40
mv -v $ROOTFS_DIR/usr/lib/libpcre.so.* $ROOTFS_DIR/lib
ln -sfv ../../lib/$(readlink $ROOTFS_DIR/usr/lib/libpcre.so) $ROOTFS_DIR/usr/lib/libpcre.so
rm -rf $BUILD_DIR/pcre-8.40

$STEP "glib 2.52.0"
$EXTRACT $SOURCES_DIR/glib-2.52.0.tar.xz $BUILD_DIR
sed -i -e "s# tests##" $BUILD_DIR/glib-2.52.0/Makefile.am
sed -i -e "s# tests##" $BUILD_DIR/glib-2.52.0/gio/Makefile.am
sed -i -e "s# tests##" $BUILD_DIR/glib-2.52.0/glib/Makefile.am
patch -Np0 -i $SUPPORT_DIR/glib/glib-2.52.0-as_fn_error.patch -d $BUILD_DIR/glib-2.52.0
( cd $BUILD_DIR/glib-2.52.0 && \
ac_cv_func_posix_getpwuid_r=yes \
glib_cv_stack_grows=no \
glib_cv_uscore=no \
ac_cv_func_strtod=yes \
ac_fsusage_space=yes \
fu_cv_sys_stat_statfs2_bsize=yes \
ac_cv_func_closedir_void=no \
ac_cv_func_getloadavg=no \
ac_cv_lib_util_getloadavg=no \
ac_cv_lib_getloadavg_getloadavg=no \
ac_cv_func_getgroups=yes \
ac_cv_func_getgroups_works=yes \
ac_cv_func_chown_works=yes \
ac_cv_have_decl_euidaccess=no \
ac_cv_func_euidaccess=no \
ac_cv_have_decl_strnlen=yes \
ac_cv_func_strnlen_working=yes \
ac_cv_func_lstat_dereferences_slashed_symlink=yes \
ac_cv_func_lstat_empty_string_bug=no \
ac_cv_func_stat_empty_string_bug=no \
vb_cv_func_rename_trailing_slash_bug=no \
ac_cv_have_decl_nanosleep=yes \
jm_cv_func_nanosleep_works=yes \
gl_cv_func_working_utimes=yes \
ac_cv_func_utime_null=yes \
ac_cv_have_decl_strerror_r=yes \
ac_cv_func_strerror_r_char_p=no \
jm_cv_func_svid_putenv=yes \
ac_cv_func_getcwd_null=yes \
ac_cv_func_getdelim=yes \
ac_cv_func_mkstemp=yes \
utils_cv_func_mkstemp_limitations=no \
utils_cv_func_mkdir_trailing_slash_bug=no \
jm_cv_func_gettimeofday_clobber=no \
gl_cv_func_working_readdir=yes \
jm_ac_cv_func_link_follows_symlink=no \
utils_cv_localtime_cache=no \
ac_cv_struct_st_mtim_nsec=no \
gl_cv_func_tzset_clobber=no \
gl_cv_func_getcwd_null=yes \
gl_cv_func_getcwd_path_max=yes \
ac_cv_func_fnmatch_gnu=yes \
am_getline_needs_run_time_check=no \
am_cv_func_working_getline=yes \
gl_cv_func_mkdir_trailing_slash_bug=no \
gl_cv_func_mkstemp_limitations=no \
ac_cv_func_working_mktime=yes \
jm_cv_func_working_re_compile_pattern=yes \
ac_use_included_regex=no \
gl_cv_c_restrict=no \
ac_cv_path_GLIB_GENMARSHAL=$TOOLS_DIR/usr/bin/glib-genmarshal \
ac_cv_prog_F77=no \
ac_cv_func_posix_getgrgid_r=no \
glib_cv_long_long_format=ll \
ac_cv_func_printf_unix98=yes \
ac_cv_func_vsnprintf_c99=yes \
ac_cv_func_newlocale=no \
ac_cv_func_uselocale=no \
ac_cv_func_strtod_l=no \
ac_cv_func_strtoll_l=no \
ac_cv_func_strtoull_l=no \
gt_cv_c_wchar_t=yes \
glib_cv_have_qsort_r=yes \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--disable-static \
--enable-shared \
--with-pcre=system \
--disable-libelf )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/glib-2.52.0
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/glib-2.52.0
rm -rf $BUILD_DIR/glib-2.52.0

$STEP "pkg-config 0.29.2"
$EXTRACT $SOURCES_DIR/pkg-config-0.29.2.tar.gz $BUILD_DIR
( cd $BUILD_DIR/pkg-config-0.29.2 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--disable-compile-warnings \
--disable-host-tool \
--docdir=/usr/share/doc/pkg-config-0.29.2 )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/pkg-config-0.29.2
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/pkg-config-0.29.2
rm -rf $BUILD_DIR/pkg-config-0.29.2

$STEP "sed 4.4"
$EXTRACT $SOURCES_DIR/sed-4.4.tar.xz $BUILD_DIR
sed -i 's/usr/tools/' $BUILD_DIR/sed-4.4/build-aux/help2man
sed -i 's/panic-tests.sh//' $BUILD_DIR/sed-4.4/Makefile.in
( cd $BUILD_DIR/sed-4.4 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--bindir=/bin )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/sed-4.4
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/sed-4.4
rm -rf $BUILD_DIR/sed-4.4

$STEP "shadow 4.4"
$EXTRACT $SOURCES_DIR/shadow-4.4.tar.xz $BUILD_DIR
sed -i 's/groups$(EXEEXT) //' $BUILD_DIR/shadow-4.4/src/Makefile.in
find $BUILD_DIR/shadow-4.4/man -name Makefile.in -exec sed -i 's/groups\.1 / /'   {} \;
find $BUILD_DIR/shadow-4.4/man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \;
find $BUILD_DIR/shadow-4.4/man -name Makefile.in -exec sed -i 's/passwd\.5 / /'   {} \;
sed -i -e 's|#ENCRYPT_METHOD DES|ENCRYPT_METHOD SHA512|' -e 's|/var/spool/mail|/var/mail|' $BUILD_DIR/shadow-4.4/etc/login.defs
patch -Np0 -l -i $SUPPORT_DIR/shadow/shadow-4.4_1.patch -d $BUILD_DIR/shadow-4.4
sed -i 's/1000/999/' $BUILD_DIR/shadow-4.4/etc/useradd
sed -i -e '47 d' -e '60,65 d' $BUILD_DIR/shadow-4.4/libmisc/myname.c
( cd $BUILD_DIR/shadow-4.4 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--sysconfdir=/etc \
--with-group-name-max-length=32 )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/shadow-4.4
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/shadow-4.4
sed -i 's/yes/no/' $ROOTFS_DIR/etc/default/useradd
rm -rf $BUILD_DIR/shadow-4.4

$STEP "psmisc 22.21"
$EXTRACT $SOURCES_DIR/psmisc-22.21.tar.gz $BUILD_DIR
( cd $BUILD_DIR/psmisc-22.21 && \
ac_cv_func_malloc_0_nonnull=yes \
ac_cv_func_realloc_0_nonnull=yes \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/psmisc-22.21
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/psmisc-22.21
mv -v $ROOTFS_DIR/usr/bin/fuser $ROOTFS_DIR/bin
mv -v $ROOTFS_DIR/usr/bin/killall $ROOTFS_DIR/bin
rm -rf $BUILD_DIR/psmisc-22.21

$STEP "iana-etc 2.30"
$EXTRACT $SOURCES_DIR/iana-etc-2.30.tar.bz2 $BUILD_DIR
patch -Np1 -i $SUPPORT_DIR/iana-etc/iana-etc-2.30-update-2.patch -d $BUILD_DIR/iana-etc-2.30
make -j$CONFIG_PARALLEL_JOBS get -C $BUILD_DIR/iana-etc-2.30
make -j$CONFIG_PARALLEL_JOBS STRIP=yes -C $BUILD_DIR/iana-etc-2.30
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/iana-etc-2.30
rm -rf $BUILD_DIR/iana-etc-2.30

$STEP "bison 3.0.4"
$EXTRACT $SOURCES_DIR/bison-3.0.4.tar.xz $BUILD_DIR
( cd $BUILD_DIR/bison-3.0.4 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--docdir=/usr/share/doc/bison-3.0.4 )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/bison-3.0.4
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/bison-3.0.4
rm -rf $BUILD_DIR/bison-3.0.4

$STEP "flex 2.6.4"
$EXTRACT $SOURCES_DIR/flex-2.6.4.tar.gz $BUILD_DIR
( cd $BUILD_DIR/flex-2.6.4 && \
HELP2MAN=true \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--docdir=/usr/share/doc/flex-2.6.4 \
--disable-bootstrap )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/flex-2.6.4
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/flex-2.6.4
ln -sv flex $ROOTFS_DIR/usr/bin/lex
rm -rf $BUILD_DIR/flex-2.6.4

$STEP "grep 3.0"
$EXTRACT $SOURCES_DIR/grep-3.0.tar.xz $BUILD_DIR
( cd $BUILD_DIR/grep-3.0 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--bindir=/bin )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/grep-3.0
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/grep-3.0
rm -rf $BUILD_DIR/grep-3.0

$STEP "bash 4.4"
$EXTRACT $SOURCES_DIR/bash-4.4.tar.gz $BUILD_DIR
patch -Np1 -i $SUPPORT_DIR/bash/bash-4.4-upstream_fixes-1.patch -d $BUILD_DIR/bash-4.4
( cd $BUILD_DIR/bash-4.4 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--docdir=/usr/share/doc/bash-4.4 \
--without-bash-malloc \
--with-installed-readline )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/bash-4.4
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/bash-4.4
mv -vf $ROOTFS_DIR/usr/bin/bash $ROOTFS_DIR/bin
ln -svf bash $ROOTFS_DIR/bin/sh
rm -rf $BUILD_DIR/bash-4.4

$STEP "libtool 2.4.6"
$EXTRACT $SOURCES_DIR/libtool-2.4.6.tar.xz $BUILD_DIR
( cd $BUILD_DIR/libtool-2.4.6 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/libtool-2.4.6
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/libtool-2.4.6
rm -rf $BUILD_DIR/libtool-2.4.6

$STEP "gdbm 1.13"
$EXTRACT $SOURCES_DIR/gdbm-1.13.tar.gz $BUILD_DIR
( cd $BUILD_DIR/gdbm-1.13 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--disable-static \
--enable-libgdbm-compat )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/gdbm-1.13
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/gdbm-1.13
rm -rf $BUILD_DIR/gdbm-1.13

$STEP "gperf 3.0.4"
$EXTRACT $SOURCES_DIR/gperf-3.0.4.tar.gz $BUILD_DIR
( cd $BUILD_DIR/gperf-3.0.4 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--docdir=/usr/share/doc/gperf-3.0.4 )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/gperf-3.0.4
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/gperf-3.0.4
rm -rf $BUILD_DIR/gperf-3.0.4

$STEP "inetutils 1.9.4"
$EXTRACT $SOURCES_DIR/inetutils-1.9.4.tar.xz $BUILD_DIR
patch -Np1 -i $SUPPORT_DIR/inetutils/inetutils-1.9-PATH_PROCNET_DEV.patch -d $BUILD_DIR/inetutils-1.9.4
( cd $BUILD_DIR/inetutils-1.9.4 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--localstatedir=/var \
--disable-logger \
--disable-whois \
--disable-rcp \
--disable-rexec \
--disable-rlogin \
--disable-rsh \
--disable-servers )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/inetutils-1.9.4
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/inetutils-1.9.4
mv -v $ROOTFS_DIR/usr/bin/{hostname,ping,ping6,traceroute} $ROOTFS_DIR/bin
chmod -v 755 $ROOTFS_DIR/bin/{ping,ping6,traceroute}
mv -v $ROOTFS_DIR/usr/bin/ifconfig $ROOTFS_DIR/sbin
rm -rf $BUILD_DIR/inetutils-1.9.4

$STEP "autoconf 2.69"
$EXTRACT $SOURCES_DIR/autoconf-2.69.tar.xz $BUILD_DIR
( cd $BUILD_DIR/autoconf-2.69 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/autoconf-2.69
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/autoconf-2.69
rm -rf $BUILD_DIR/autoconf-2.69

$STEP "automake 1.15"
$EXTRACT $SOURCES_DIR/automake-1.15.tar.xz $BUILD_DIR
( cd $BUILD_DIR/automake-1.15 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--docdir=/usr/share/doc/automake-1.15 )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/automake-1.15
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/automake-1.15
rm -rf $BUILD_DIR/automake-1.15

$STEP "xz 5.2.3"
$EXTRACT $SOURCES_DIR/xz-5.2.3.tar.xz $BUILD_DIR
( cd $BUILD_DIR/xz-5.2.3 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--disable-static \
--docdir=/usr/share/doc/xz-5.2.3 )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/xz-5.2.3
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/xz-5.2.3
mv -v $ROOTFS_DIR/usr/bin/{lzma,unlzma,lzcat,xz,unxz,xzcat} $ROOTFS_DIR/bin
mv -v $ROOTFS_DIR/usr/lib/liblzma.so.* $ROOTFS_DIR/lib
ln -svf ../../lib/$(readlink $ROOTFS_DIR/usr/lib/liblzma.so) $ROOTFS_DIR/usr/lib/liblzma.so
rm -rf $BUILD_DIR/xz-5.2.3

$STEP "kmod 24"
$EXTRACT $SOURCES_DIR/kmod-24.tar.xz $BUILD_DIR
( cd $BUILD_DIR/kmod-24 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--bindir=/bin \
--sysconfdir=/etc \
--with-rootlibdir=/lib \
--with-xz \
--with-zlib )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/kmod-24
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/kmod-24
for target in depmod insmod lsmod modinfo modprobe rmmod ; do \
	ln -svf ../bin/kmod $ROOTFS_DIR/sbin/${target} ; \
done
ln -svf kmod $ROOTFS_DIR/bin/lsmod
rm -rf $BUILD_DIR/kmod-24

$STEP "gettext 0.19.8.1"
$EXTRACT $SOURCES_DIR/gettext-0.19.8.1.tar.xz $BUILD_DIR
( cd $BUILD_DIR/gettext-0.19.8.1 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--disable-static \
--docdir=/usr/share/doc/gettext-0.19.8.1 )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/gettext-0.19.8.1
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/gettext-0.19.8.1
chmod -v 755 $ROOTFS_DIR/usr/lib/preloadable_libintl.so
rm -rf $BUILD_DIR/gettext-0.19.8.1

$STEP "procps-ng 3.3.12"
$EXTRACT $SOURCES_DIR/procps-ng-3.3.12.tar.xz $BUILD_DIR
( cd $BUILD_DIR/procps-ng-3.3.12 && \
ac_cv_func_malloc_0_nonnull=yes \
ac_cv_func_realloc_0_nonnull=yes \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--exec-prefix= \
--libdir=/usr/lib \
--docdir=/usr/share/doc/procps-ng-3.3.12 \
--disable-static \
--disable-kill )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/procps-ng-3.3.12
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/procps-ng-3.3.12
mv -v $ROOTFS_DIR/usr/lib/libprocps.so.* $ROOTFS_DIR/lib
ln -sfv ../../lib/$(readlink $ROOTFS_DIR/usr/lib/libprocps.so) $ROOTFS_DIR/usr/lib/libprocps.so
rm -rf $BUILD_DIR/procps-ng-3.3.12

$STEP "util-linux 2.29.2"
$EXTRACT $SOURCES_DIR/util-linux-2.29.2.tar.xz $BUILD_DIR
mkdir -pv $ROOTFS_DIR/var/lib/hwclock
( cd $BUILD_DIR/util-linux-2.29.2 && \
./configure \
ADJTIME_PATH=/var/lib/hwclock/adjtime \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--docdir=/usr/share/doc/util-linux-2.29.2 \
--disable-rpath \
--disable-makeinstall-chown \
--disable-chfn-chsh \
--disable-login \
--disable-nologin \
--disable-su \
--disable-setpriv \
--disable-runuser \
--disable-pylibmount \
--disable-static \
--without-python \
--without-systemd \
--without-systemdsystemunitdir )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/util-linux-2.29.2
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/util-linux-2.29.2
rm -rf $BUILD_DIR/util-linux-2.29.2

$STEP "e2fsprogs 1.43.4"
$EXTRACT $SOURCES_DIR/e2fsprogs-1.43.4.tar.gz $BUILD_DIR
( cd $BUILD_DIR/e2fsprogs-1.43.4 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--bindir=/bin \
--with-root-prefix="" \
--enable-elf-shlibs \
--disable-libblkid \
--disable-libuuid \
--disable-uuidd \
--disable-fsck )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/e2fsprogs-1.43.4
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/e2fsprogs-1.43.4
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install-libs -C $BUILD_DIR/e2fsprogs-1.43.4
chmod -v u+w $ROOTFS_DIR/usr/lib/{libcom_err,libe2p,libext2fs,libss}.a
rm -rf $BUILD_DIR/e2fsprogs-1.43.4

$STEP "coreutils 8.27"
$EXTRACT $SOURCES_DIR/coreutils-8.27.tar.xz $BUILD_DIR
patch -Np1 -i $SUPPORT_DIR/coreutils/coreutils-8.27-i18n-1.patch -d $BUILD_DIR/coreutils-8.27
sed -i 's#/man/help2man#/man/help2man --no-discard-stderr#g' $BUILD_DIR/coreutils-8.27/man/local.mk
( cd $BUILD_DIR/coreutils-8.27 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--enable-no-install-program=kill,uptime )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/coreutils-8.27
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/coreutils-8.27
mv -v $ROOTFS_DIR/usr/bin/{cat,chgrp,chmod,chown,cp,date,dd,df,echo} $ROOTFS_DIR/bin
mv -v $ROOTFS_DIR/usr/bin/{false,ln,ls,mkdir,mknod,mv,pwd,rm} $ROOTFS_DIR/bin
mv -v $ROOTFS_DIR/usr/bin/{rmdir,stty,sync,true,uname} $ROOTFS_DIR/bin
mv -v $ROOTFS_DIR/usr/bin/chroot $ROOTFS_DIR/usr/sbin
mv -v $ROOTFS_DIR/usr/share/man/man1/chroot.1 $ROOTFS_DIR/usr/share/man/man8/chroot.8
sed -i s/\"1\"/\"8\"/1 $ROOTFS_DIR/usr/share/man/man8/chroot.8
mv -v $ROOTFS_DIR/usr/bin/{head,sleep,nice,test,[} $ROOTFS_DIR/bin
rm -rf $BUILD_DIR/coreutils-8.27

$STEP "diffutils 3.5"
$EXTRACT $SOURCES_DIR/diffutils-3.5.tar.xz $BUILD_DIR
sed -i 's:= mkdir_p:= /bin/mkdir -p:' $BUILD_DIR/diffutils-3.5/po/Makefile.in.in
( cd $BUILD_DIR/diffutils-3.5 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/diffutils-3.5
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/diffutils-3.5
rm -rf $BUILD_DIR/diffutils-3.5

$STEP "gawk 4.1.4"
$EXTRACT $SOURCES_DIR/gawk-4.1.4.tar.xz $BUILD_DIR
( cd $BUILD_DIR/gawk-4.1.4 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/gawk-4.1.4
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/gawk-4.1.4
rm -rf $BUILD_DIR/gawk-4.1.4

$STEP "findutils 4.6.0"
$EXTRACT $SOURCES_DIR/findutils-4.6.0.tar.gz $BUILD_DIR
( cd $BUILD_DIR/findutils-4.6.0 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--localstatedir=/var/lib/locate )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/findutils-4.6.0
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/findutils-4.6.0
mv -v $ROOTFS_DIR/usr/bin/find $ROOTFS_DIR/bin
sed -i 's/find:=${BINDIR}/find:=\/bin/' $ROOTFS_DIR/usr/bin/updatedb
rm -rf $BUILD_DIR/findutils-4.6.0

$STEP "less 487"
$EXTRACT $SOURCES_DIR/less-487.tar.gz $BUILD_DIR
( cd $BUILD_DIR/less-487 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--sysconfdir=/etc )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/less-487
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/less-487
rm -rf $BUILD_DIR/less-487

$STEP "gzip 1.8"
$EXTRACT $SOURCES_DIR/gzip-1.8.tar.xz $BUILD_DIR
( cd $BUILD_DIR/gzip-1.8 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/gzip-1.8
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/gzip-1.8
mv -v $ROOTFS_DIR/usr/bin/gzip $ROOTFS_DIR/bin
rm -rf $BUILD_DIR/gzip-1.8

$STEP "iproute2 4.10.0"
$EXTRACT $SOURCES_DIR/iproute2-4.10.0.tar.xz $BUILD_DIR
sed -i /ARPD/d $BUILD_DIR/iproute2-4.10.0/Makefile
sed -i 's/arpd.8//' $BUILD_DIR/iproute2-4.10.0/man/man8/Makefile
rm -v $BUILD_DIR/iproute2-4.10.0/doc/arpd.sgml
sed -i 's/m_ipt.o//' $BUILD_DIR/iproute2-4.10.0/tc/Makefile
( cd $BUILD_DIR/iproute2-4.10.0 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--docdir=/usr/share/doc/iproute2-4.10.0 )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/iproute2-4.10.0
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/iproute2-4.10.0
rm -rf $BUILD_DIR/iproute2-4.10.0

$STEP "kbd 2.0.4"
$EXTRACT $SOURCES_DIR/kbd-2.0.4.tar.xz $BUILD_DIR
patch -Np1 -i $SUPPORT_DIR/kbd/kbd-2.0.4-backspace-1.patch -d $BUILD_DIR/kbd-2.0.4
sed -i 's/\(RESIZECONS_PROGS=\)yes/\1no/g' $BUILD_DIR/kbd-2.0.4/configure
sed -i 's/resizecons.8 //' $BUILD_DIR/kbd-2.0.4/docs/man/man8/Makefile.in
( cd $BUILD_DIR/kbd-2.0.4 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--disable-vlock )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/kbd-2.0.4
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/kbd-2.0.4
rm -rf $BUILD_DIR/kbd-2.0.4

$STEP "libpipeline 1.4.1"
$EXTRACT $SOURCES_DIR/libpipeline-1.4.1.tar.gz $BUILD_DIR
( cd $BUILD_DIR/libpipeline-1.4.1 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/libpipeline-1.4.1
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/libpipeline-1.4.1
rm -rf $BUILD_DIR/libpipeline-1.4.1

$STEP "make 4.2.1"
$EXTRACT $SOURCES_DIR/make-4.2.1.tar.bz2 $BUILD_DIR
( cd $BUILD_DIR/make-4.2.1 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/make-4.2.1
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/make-4.2.1
rm -rf $BUILD_DIR/make-4.2.1

$STEP "patch 2.7.5"
$EXTRACT $SOURCES_DIR/patch-2.7.5.tar.xz $BUILD_DIR
( cd $BUILD_DIR/patch-2.7.5 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/patch-2.7.5
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/patch-2.7.5
rm -rf $BUILD_DIR/patch-2.7.5

$STEP "sysklogd 1.5.1"
$EXTRACT $SOURCES_DIR/sysklogd-1.5.1.tar.gz $BUILD_DIR
sed -i '/Error loading kernel symbols/{n;n;d}' $BUILD_DIR/sysklogd-1.5.1/ksym_mod.c
sed -i 's/union wait/int/' $BUILD_DIR/sysklogd-1.5.1/syslogd.c
make -j$CONFIG_PARALLEL_JOBS CC=$TOOLS_DIR/usr/bin/$CONFIG_TARGET-gcc -C $BUILD_DIR/sysklogd-1.5.1
install -D -m 0500 $BUILD_DIR/sysklogd-1.5.1/syslogd $ROOTFS_DIR/sbin/syslogd
install -D -m 0500 $BUILD_DIR/sysklogd-1.5.1/klogd $ROOTFS_DIR/sbin/klogd
cat > $ROOTFS_DIR/etc/syslog.conf << "EOF"
# Begin /etc/syslog.conf

auth,authpriv.* -/var/log/auth.log
*.*;auth,authpriv.none -/var/log/sys.log
daemon.* -/var/log/daemon.log
kern.* -/var/log/kern.log
mail.* -/var/log/mail.log
user.* -/var/log/user.log
*.emerg *

# End /etc/syslog.conf
EOF
rm -rf $BUILD_DIR/sysklogd-1.5.1

$STEP "sysvinit 2.88dsf"
$EXTRACT $SOURCES_DIR/sysvinit-2.88dsf.tar.bz2 $BUILD_DIR
patch -Np1 -i $SUPPORT_DIR/sysvinit/sysvinit-2.88dsf-consolidated-1.patch -d $BUILD_DIR/sysvinit-2.88dsf
make -j$CONFIG_PARALLEL_JOBS CC=$TOOLS_DIR/usr/bin/$CONFIG_TARGET-gcc -C $BUILD_DIR/sysvinit-2.88dsf/src
make -j$CONFIG_PARALLEL_JOBS ROOT=$ROOTFS_DIR install -C $BUILD_DIR/sysvinit-2.88dsf/src
rm -rf $BUILD_DIR/sysvinit-2.88dsf

$STEP "eudev 3.2.1"
$EXTRACT $SOURCES_DIR/eudev-3.2.1.tar.gz $BUILD_DIR
( cd $BUILD_DIR/eudev-3.2.1 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--bindir=/sbin \
--sbindir=/sbin \
--libdir=/usr/lib \
--sysconfdir=/etc \
--libexecdir=/lib \
--with-rootprefix= \
--with-rootlibdir=/lib \
--enable-manpages \
--disable-static \
--config-cache )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/eudev-3.2.1
mkdir -pv $ROOTFS_DIR/lib/udev/rules.d
mkdir -pv $ROOTFS_DIR/etc/udev/rules.d
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/eudev-3.2.1
tar -jxf $SUPPORT_DIR/udev/udev-lfs-20140408.tar.bz2 -C $BUILD_DIR/eudev-3.2.1
( cd $BUILD_DIR/eudev-3.2.1 && make -f udev-lfs-20140408/Makefile.lfs DESTDIR=$ROOTFS_DIR install )
rm -rf $BUILD_DIR/eudev-3.2.1

$STEP "tar 1.29"
$EXTRACT $SOURCES_DIR/tar-1.29.tar.xz $BUILD_DIR
( cd $BUILD_DIR/tar-1.29 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--bindir=/bin )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/tar-1.29
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/tar-1.29
rm -rf $BUILD_DIR/tar-1.29

$STEP "texinfo 6.3"
$EXTRACT $SOURCES_DIR/texinfo-6.3.tar.xz $BUILD_DIR
( cd $BUILD_DIR/texinfo-6.3 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--disable-static )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/texinfo-6.3
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/texinfo-6.3
rm -rf $BUILD_DIR/texinfo-6.3

$STEP "Vim 8.0.069"
$EXTRACT $SOURCES_DIR/vim-8.0.069.tar.bz2 $BUILD_DIR
echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> $BUILD_DIR/vim80/src/feature.h
( cd $BUILD_DIR/vim80 && \
vim_cv_toupper_broken=no \
vim_cv_terminfo=yes \
vim_cv_tty_group=world \
vim_cv_tty_mode=0620 \
vim_cv_getcwd_broken=no \
vim_cv_stat_ignores_slash=yes \
vim_cv_memmove_handles_overlap=yes \
ac_cv_sizeof_int=4 \
ac_cv_small_wchar_t=no \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--enable-multibyte \
--enable-gui=no \
--disable-gtktest \
--disable-xim \
--with-features=normal \
--disable-gpm \
--without-x \
--disable-netbeans \
--with-tlib=ncurses )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/vim80
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/vim80
ln -svf vim $ROOTFS_DIR/usr/bin/vi
ln -svf ../vim/vim80/doc $ROOTFS_DIR/usr/share/doc/vim-8.0.069
cat > $ROOTFS_DIR/etc/vimrc << "EOF"
" Begin /etc/vimrc
set nocompatible
set backspace=2
set mouse=r
syntax on
if (&term == "iterm") || (&term == "putty")
set background=dark
endif
" End /etc/vimrc
EOF
rm -rf $BUILD_DIR/vim80

$STEP "tzdata2017b"
mkdir -p $BUILD_DIR/tzdata2017b
tar -zxf $SOURCES_DIR/tzdata2017b.tar.gz -C $BUILD_DIR/tzdata2017b
export ZONEINFO=$ROOTFS_DIR/usr/share/zoneinfo
mkdir -pv $ZONEINFO/posix
mkdir -pv $ZONEINFO/right
for tz in $BUILD_DIR/tzdata2017b/etcetera $BUILD_DIR/tzdata2017b/southamerica $BUILD_DIR/tzdata2017b/northamerica $BUILD_DIR/tzdata2017b/europe $BUILD_DIR/tzdata2017b/africa $BUILD_DIR/tzdata2017b/antarctica $BUILD_DIR/tzdata2017b/asia $BUILD_DIR/tzdata2017b/australasia $BUILD_DIR/tzdata2017b/backward $BUILD_DIR/tzdata2017b/pacificnew $BUILD_DIR/tzdata2017b/systemv ; do \
	zic -L /dev/null -d $ZONEINFO -y "sh yearistype.sh" ${tz} ; \
	zic -L /dev/null -d $ZONEINFO/posix -y "sh yearistype.sh" ${tz} ; \
	zic -L $BUILD_DIR/tzdata2017b/leapseconds -d $ZONEINFO/right -y "sh yearistype.sh" ${tz} ; \
done
cp -v $BUILD_DIR/tzdata2017b/zone.tab $ZONEINFO
cp -v $BUILD_DIR/tzdata2017b/zone1970.tab $ZONEINFO
cp -v $BUILD_DIR/tzdata2017b/iso3166.tab $ZONEINFO
zic -d $ZONEINFO -p America/New_York
if ! [ -f $ROOTFS_DIR/usr/share/zoneinfo/$CONFIG_LOCAL_TIMEZONE ] ; then
    echo "Seems like your timezone won't work out. Defaulting to Seoul. Either fix it yourself later or consider moving there."
    cp -v $ROOTFS_DIR/usr/share/zoneinfo/Asia/Seoul $ROOTFS_DIR/etc/localtime
else
    cp -v $ROOTFS_DIR/usr/share/zoneinfo/$CONFIG_LOCAL_TIMEZONE $ROOTFS_DIR/etc/localtime
fi
unset ZONEINFO
rm -rf $BUILD_DIR/tzdata2017b

$STEP "Setting Up System Bootscripts"
make DESTDIR=$ROOTFS_DIR install -C $SUPPORT_DIR/bootscripts

$STEP "libcap 2.25"
$EXTRACT $SOURCES_DIR/libcap-2.25.tar.xz $BUILD_DIR
patch -Np1 -i $SUPPORT_DIR/libcap/libcap-2.25-build-system-fixes-for-cross-compilation.patch -d $BUILD_DIR/libcap-2.25
CC="$TOOLS_DIR/usr/bin/$CONFIG_TARGET-gcc" AR="$TOOLS_DIR/usr/bin/$CONFIG_TARGET-ar" LD="$TOOLS_DIR/usr/bin/$CONFIG_TARGET-ld" RANLIB="$TOOLS_DIR/usr/bin/$CONFIG_TARGET-ranlib" BUILD_CC="gcc" BUILD_CFLAGS="-O2 -I$TOOLS_DIR/usr/include" make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/libcap-2.25/libcap
make -j$CONFIG_PARALLEL_JOBS CC="$TOOLS_DIR/usr/bin/$CONFIG_TARGET-gcc" DESTDIR=$ROOTFS_DIR prefix=/usr lib=lib install -C $BUILD_DIR/libcap-2.25/libcap
rm -rf $BUILD_DIR/libcap-2.25

$STEP "openssl 1.0.2k"
$EXTRACT $SOURCES_DIR/openssl-1.0.2k.tar.gz $BUILD_DIR
( cd $BUILD_DIR/openssl-1.0.2k && \
./Configure \
linux-armv4 \
--prefix=/usr \
--openssldir=/etc/ssl \
--libdir=/lib \
shared \
zlib-dynamic )
sed -i -e "s#-march=[-a-z0-9] ##" -e "s#-mcpu=[-a-z0-9] ##g" $BUILD_DIR/openssl-1.0.2k/Makefile
sed -i -e "s# build_tests##" $BUILD_DIR/openssl-1.0.2k/Makefile
make -j1 -C $BUILD_DIR/openssl-1.0.2k
make -j1 INSTALL_PREFIX=$ROOTFS_DIR install -C $BUILD_DIR/openssl-1.0.2k
rm -rf $BUILD_DIR/openssl-1.0.2k

$STEP "openssh 7.4p1"
$EXTRACT $SOURCES_DIR/openssh-7.4p1.tar.gz $BUILD_DIR
( cd $BUILD_DIR/openssh-7.4p1 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--sysconfdir=/etc/ssh \
--with-md5-passwords \
--with-privsep-path=/var/lib/sshd \
--disable-strip )
make -j$CONFIG_PARALLEL_JOBS LD=$TOOLS_DIR/usr/bin/$CONFIG_TARGET-gcc -C $BUILD_DIR/openssh-7.4p1
install -v -m700 -d $ROOTFS_DIR/var/lib/sshd
rm -rf $ROOTFS_DIR/usr/share/man/man8
make -j$CONFIG_PARALLEL_JOBS LD=$TOOLS_DIR/usr/bin/$CONFIG_TARGET-gcc DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/openssh-7.4p1
install -v -m755 $BUILD_DIR/openssh-7.4p1/contrib/ssh-copy-id $ROOTFS_DIR/usr/bin
echo 'sshd:x:50:' >> $ROOTFS_DIR/etc/group
echo 'sshd:x:50:50:sshd PrivSep:/var/lib/sshd:/bin/false' >> $ROOTFS_DIR/etc/passwd
echo "PermitRootLogin yes" >> $ROOTFS_DIR/etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> $ROOTFS_DIR/etc/ssh/sshd_config
cp -v $SUPPORT_DIR/openssh/sshd $ROOTFS_DIR/etc/rc.d/init.d/sshd
chmod -v 755 $ROOTFS_DIR/etc/rc.d/init.d/sshd
ln -svf ../init.d/sshd $ROOTFS_DIR/etc/rc.d/rc0.d/K30sshd
ln -svf ../init.d/sshd $ROOTFS_DIR/etc/rc.d/rc1.d/K30sshd
ln -svf ../init.d/sshd $ROOTFS_DIR/etc/rc.d/rc2.d/K30sshd
ln -svf ../init.d/sshd $ROOTFS_DIR/etc/rc.d/rc3.d/S30sshd
ln -svf ../init.d/sshd $ROOTFS_DIR/etc/rc.d/rc4.d/S30sshd
ln -svf ../init.d/sshd $ROOTFS_DIR/etc/rc.d/rc5.d/S30sshd
ln -svf ../init.d/sshd $ROOTFS_DIR/etc/rc.d/rc6.d/K30sshd
rm -rf $BUILD_DIR/openssh-7.4p1

$STEP "ntp 4.2.8p9"
$EXTRACT $SOURCES_DIR/ntp-4.2.8p9.tar.gz $BUILD_DIR
( cd $BUILD_DIR/ntp-4.2.8p9 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=/usr \
--bindir=/usr/sbin \
--sysconfdir=/etc \
--enable-linuxcaps \
--with-yielding-select=yes \
--with-lineeditlibs=readline \
--docdir=/usr/share/doc/ntp-4.2.8p9 )
make -j1 -C $BUILD_DIR/ntp-4.2.8p9
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$ROOTFS_DIR install -C $BUILD_DIR/ntp-4.2.8p9
cp -v $SUPPORT_DIR/ntp/ntp.conf $ROOTFS_DIR/etc/ntp.conf
cp -v $SUPPORT_DIR/ntp/ntpd $ROOTFS_DIR/etc/rc.d/init.d/ntpd
chmod -v 755 $ROOTFS_DIR/etc/rc.d/init.d/ntpd
ln -svf ../init.d/ntpd $ROOTFS_DIR/etc/rc.d/rc0.d/K46ntpd
ln -svf ../init.d/ntpd $ROOTFS_DIR/etc/rc.d/rc1.d/K46ntpd
ln -svf ../init.d/ntpd $ROOTFS_DIR/etc/rc.d/rc2.d/K46ntpd
ln -svf ../init.d/ntpd $ROOTFS_DIR/etc/rc.d/rc3.d/S26ntpd
ln -svf ../init.d/ntpd $ROOTFS_DIR/etc/rc.d/rc4.d/S26ntpd
ln -svf ../init.d/ntpd $ROOTFS_DIR/etc/rc.d/rc5.d/S26ntpd
ln -svf ../init.d/ntpd $ROOTFS_DIR/etc/rc.d/rc6.d/K46ntpd
echo 'ntp:x:87:' >> $ROOTFS_DIR/etc/group
echo 'ntp:x:87:87:Network Time Protocol:/var/lib/ntp:/bin/false' >> $ROOTFS_DIR/etc/passwd
mkdir -pv $ROOTFS_DIR/var/lib/ntp
rm -rf $BUILD_DIR/ntp-4.2.8p9

$STEP "lsb-release 1.4"
install -v -m 755 $SUPPORT_DIR/lsb-release/lsb_release $ROOTFS_DIR/usr/bin/lsb_release
sed -i "s|n/a|unavailable|" $ROOTFS_DIR/usr/bin/lsb_release

$STEP "glibc 2.25"
$EXTRACT $SOURCES_DIR/glibc-2.25.tar.xz $BUILD_DIR
mkdir -p $BUILD_DIR/glibc-2.25/glibc-build
patch -Np1 -i $SUPPORT_DIR/glibc/glibc-2.25-fhs-1.patch -d $BUILD_DIR/glibc-2.25
( cd $BUILD_DIR/glibc-2.25/glibc-build && \
AR="$TOOLS_DIR/usr/bin/$CONFIG_TARGET-ar" \
CC="$TOOLS_DIR/usr/bin/$CONFIG_TARGET-gcc" \
RANLIB="$TOOLS_DIR/usr/bin/$CONFIG_TARGET-ranlib" \
BUILD_CC="gcc" \
$BUILD_DIR/glibc-2.25/configure \
libc_cv_slibdir=/lib \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--with-pkgversion="$CONFIG_PKG_VERSION" \
--prefix=/usr \
--enable-obsolete-rpc \
--enable-kernel=4.4.45 \
--enable-stack-protector=strong \
--with-headers=$SYSROOT_DIR/usr/include )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/glibc-2.25/glibc-build
touch $ROOTFS_DIR/etc/ld.so.conf
make -j$CONFIG_PARALLEL_JOBS install_root=$ROOTFS_DIR install -C $BUILD_DIR/glibc-2.25/glibc-build
cp -v $BUILD_DIR/glibc-2.25/nscd/nscd.conf $ROOTFS_DIR/etc/nscd.conf
mkdir -pv $ROOTFS_DIR/var/cache/nscd
cat > $ROOTFS_DIR/etc/nsswitch.conf << "EOF"
# Begin /etc/nsswitch.conf

passwd: files
group: files
shadow: files

hosts: files dns
networks: files

protocols: files
services: files
ethers: files
rpc: files

# End /etc/nsswitch.conf
EOF
cat > $ROOTFS_DIR/etc/ld.so.conf << "EOF"
# Begin /etc/ld.so.conf

/usr/local/lib
/opt/lib

# Add an include directory
include /etc/ld.so.conf.d/*.conf

# End /etc/ld.so.conf
EOF
mkdir -pv $ROOTFS_DIR/etc/ld.so.conf.d
ln -svf ld-2.25.so $ROOTFS_DIR/lib/ld-linux.so.3
rm -rf $BUILD_DIR/glibc-2.25
