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
  binutils-2.28.tar.bz2
  gcc-6.3.0.tar.bz2
  gdbm-1.13.tar.gz
  glib-2.52.0.tar.xz
  gmp-6.1.2.tar.xz
  libcap-2.25.tar.xz
  libffi-3.2.1.tar.gz
  libpipeline-1.4.1.tar.gz
  mpc-1.0.3.tar.gz
  mpfr-3.1.5.tar.xz
  ncurses-6.0.tar.gz
  openssl-1.0.2k.tar.gz
  pcre-8.40.tar.bz2
  readline-7.0.tar.gz
  util-linux-2.29.2.tar.xz
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

$STEP "zlib 1.2.11"
$EXTRACT $SOURCES_DIR/zlib-1.2.11.tar.xz $BUILD_DIR
( cd $BUILD_DIR/zlib-1.2.11 && ./configure --prefix=$SYSROOT_DIR/usr )
make -j1 -C $BUILD_DIR/zlib-1.2.11
make -j1 LDCONFIG=true install -C $BUILD_DIR/zlib-1.2.11
rm -rf $BUILD_DIR/zlib-1.2.11

$STEP "binutils 2.28"
$EXTRACT $SOURCES_DIR/binutils-2.28.tar.bz2 $BUILD_DIR
mkdir -pv $BUILD_DIR/binutils-2.28/binutils-build
( cd $BUILD_DIR/binutils-2.28/binutils-build && \
$BUILD_DIR/binutils-2.28/configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=$SYSROOT_DIR/usr \
--enable-gold \
--enable-ld=default \
--enable-plugins \
--enable-shared \
--disable-werror \
--with-system-zlib )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/binutils-2.28/binutils-build
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/binutils-2.28/binutils-build
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
--prefix=$SYSROOT_DIR/usr \
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
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/gcc-6.3.0/gcc-build
rm -rf $BUILD_DIR/gcc-6.3.0

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
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$SYSROOT_DIR PKG_CONFIG_LIBDIR=/usr/lib/pkgconfig install -C $BUILD_DIR/ncurses-6.0
for lib in ncurses form panel menu ; do
  rm -vf                    $SYSROOT_DIR/usr/lib/lib${lib}.so
  echo "INPUT(-l${lib}w)" > $SYSROOT_DIR/usr/lib/lib${lib}.so
  ln -sfv ${lib}w.pc        $SYSROOT_DIR/usr/lib/pkgconfig/${lib}.pc
done
rm -vf                     $SYSROOT_DIR/usr/lib/libcursesw.so
echo "INPUT(-lncursesw)" > $SYSROOT_DIR/usr/lib/libcursesw.so
ln -sfv libncurses.so      $SYSROOT_DIR/usr/lib/libcurses.so
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
--prefix=$SYSROOT_DIR/usr \
--disable-static )
make -j$CONFIG_PARALLEL_JOBS SHLIB_LIBS="-lncursesw" -C $BUILD_DIR/readline-7.0
make -j$CONFIG_PARALLEL_JOBS SHLIB_LIBS="-lncurses" install -C $BUILD_DIR/readline-7.0
rm -rf $BUILD_DIR/readline-7.0

$STEP "libffi 3.2.1"
$EXTRACT $SOURCES_DIR/libffi-3.2.1.tar.gz $BUILD_DIR
( cd $BUILD_DIR/libffi-3.2.1 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=$SYSROOT_DIR/usr \
--disable-static )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/libffi-3.2.1
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/libffi-3.2.1
mv $SYSROOT_DIR/usr/lib/libffi-3.2.1/include/*.h $SYSROOT_DIR/usr/include/
sed -i -e '/^includedir.*/d' -e '/^Cflags:.*/d' $SYSROOT_DIR/usr/lib/pkgconfig/libffi.pc
rm -rf $BUILD_DIR/libffi-3.2.1

$STEP "pcre 8.40"
$EXTRACT $SOURCES_DIR/pcre-8.40.tar.bz2 $BUILD_DIR
( cd $BUILD_DIR/pcre-8.40 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=$SYSROOT_DIR/usr \
--disable-static \
--enable-shared \
--enable-pcre8 \
--disable-pcre16 \
--disable-pcre32 \
--enable-utf \
--enable-unicode-properties )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/pcre-8.40
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/pcre-8.40
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
--prefix=$SYSROOT_DIR/usr \
--disable-static \
--enable-shared \
--with-pcre=system \
--disable-libelf )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/glib-2.52.0
make -j$CONFIG_PARALLEL_JOBS LDFLAGS=-L$SYSROOT_DIR/usr/lib install -C $BUILD_DIR/glib-2.52.0
rm -rf $BUILD_DIR/glib-2.52.0

$STEP "xz 5.2.3"
$EXTRACT $SOURCES_DIR/xz-5.2.3.tar.xz $BUILD_DIR
( cd $BUILD_DIR/xz-5.2.3 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=$SYSROOT_DIR/usr \
--disable-static )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/xz-5.2.3
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/xz-5.2.3
rm -rf $BUILD_DIR/xz-5.2.3

$STEP "util-linux 2.29.2"
$EXTRACT $SOURCES_DIR/util-linux-2.29.2.tar.xz $BUILD_DIR
( cd $BUILD_DIR/util-linux-2.29.2 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=$SYSROOT_DIR/usr \
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
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/util-linux-2.29.2
rm -rf $BUILD_DIR/util-linux-2.29.2

$STEP "libpipeline 1.4.1"
$EXTRACT $SOURCES_DIR/libpipeline-1.4.1.tar.gz $BUILD_DIR
( cd $BUILD_DIR/libpipeline-1.4.1 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=$SYSROOT_DIR/usr )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/libpipeline-1.4.1
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/libpipeline-1.4.1
rm -rf $BUILD_DIR/libpipeline-1.4.1

$STEP "gdbm 1.13"
$EXTRACT $SOURCES_DIR/gdbm-1.13.tar.gz $BUILD_DIR
( cd $BUILD_DIR/gdbm-1.13 && \
./configure \
--target=$CONFIG_TARGET \
--host=$CONFIG_TARGET \
--build=$CONFIG_HOST \
--prefix=$SYSROOT_DIR/usr \
--disable-static \
--enable-libgdbm-compat )
make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/gdbm-1.13
make -j$CONFIG_PARALLEL_JOBS install -C $BUILD_DIR/gdbm-1.13
rm -rf $BUILD_DIR/gdbm-1.13

$STEP "libcap 2.25"
$EXTRACT $SOURCES_DIR/libcap-2.25.tar.xz $BUILD_DIR
patch -Np1 -i $SUPPORT_DIR/libcap/libcap-2.25-build-system-fixes-for-cross-compilation.patch -d $BUILD_DIR/libcap-2.25
CC="$TOOLS_DIR/usr/bin/$CONFIG_TARGET-gcc" AR="$TOOLS_DIR/usr/bin/$CONFIG_TARGET-ar" LD="$TOOLS_DIR/usr/bin/$CONFIG_TARGET-ld" RANLIB="$TOOLS_DIR/usr/bin/$CONFIG_TARGET-ranlib" BUILD_CC="gcc" BUILD_CFLAGS="-O2 -I$TOOLS_DIR/usr/include" make -j$CONFIG_PARALLEL_JOBS -C $BUILD_DIR/libcap-2.25/libcap
make -j$CONFIG_PARALLEL_JOBS DESTDIR=$SYSROOT_DIR prefix=/usr lib=lib install -C $BUILD_DIR/libcap-2.25/libcap
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
make -j1 INSTALL_PREFIX=$SYSROOT_DIR install -C $BUILD_DIR/openssl-1.0.2k
rm -rf $BUILD_DIR/openssl-1.0.2k
