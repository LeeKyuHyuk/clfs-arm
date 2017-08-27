include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/glib-2.52.0.tar.xz
SOURCE_URL := ftp://ftp.gnome.org/pub/gnome/sources/glib/2.52/glib-2.52.0.tar.xz
MD5 := 64283e546091dcf3c9837d5430dda022

toolchain:
	@$(STEP) "glib 2.52.0"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -i -e "s# tests##" $(BUILD_DIR)/glib-2.52.0/Makefile.am
	@sed -i -e "s# tests##" $(BUILD_DIR)/glib-2.52.0/gio/Makefile.am
	@sed -i -e "s# tests##" $(BUILD_DIR)/glib-2.52.0/glib/Makefile.am
	@patch -Np0 -i $(PACKAGES_DIR)/glib/glib-2.52.0-as_fn_error.patch -d $(BUILD_DIR)/glib-2.52.0
	@( cd $(BUILD_DIR)/glib-2.52.0 && \
	PKG_CONFIG="$(TOOLS_DIR)/bin/pkg-config" \
	PKG_CONFIG_SYSROOT_DIR="/" \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
	PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/lib/pkgconfig:$(TOOLS_DIR)/share/pkgconfig" \
	CPPFLAGS="-I$(TOOLS_DIR)/include" \
	CFLAGS="-O2 -I$(TOOLS_DIR)/include" \
	CXXFLAGS="-O2 -I$(TOOLS_DIR)/include" \
	LDFLAGS="-L$(TOOLS_DIR)/lib -Wl,-rpath,$(TOOLS_DIR)/lib" \
	CONFIG_SITE=/dev/null \
	LIBS="-lpcre -lffi" \
	./configure \
	--prefix=$(TOOLS_DIR) \
	--sysconfdir=$(TOOLS_DIR)/etc \
	--localstatedir=$(TOOLS_DIR)/var \
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
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/glib-2.52.0
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/glib-2.52.0
	@rm -rf $(BUILD_DIR)/glib-2.52.0

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "glib 2.52.0"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -i -e "s# tests##" $(BUILD_DIR)/glib-2.52.0/Makefile.am
	@sed -i -e "s# tests##" $(BUILD_DIR)/glib-2.52.0/gio/Makefile.am
	@sed -i -e "s# tests##" $(BUILD_DIR)/glib-2.52.0/glib/Makefile.am
	@patch -Np0 -i $(PACKAGES_DIR)/glib/glib-2.52.0-as_fn_error.patch -d $(BUILD_DIR)/glib-2.52.0
	@( cd $(BUILD_DIR)/glib-2.52.0 && \
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
	ac_cv_path_GLIB_GENMARSHAL=$(TOOLS_DIR)/bin/glib-genmarshal \
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
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--exec-prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--program-prefix="" \
	--disable-static \
	--enable-shared \
	--with-pcre=system \
	--disable-libelf )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/glib-2.52.0
	@make -j$(CONFIG_PARALLEL_JOBS) LDFLAGS=-L$(SYSROOT_DIR)/usr/lib DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/glib-2.52.0
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/glib-2.52.0
	@rm -rf $(BUILD_DIR)/glib-2.52.0
