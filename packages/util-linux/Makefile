include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/util-linux-2.30.1.tar.xz
SOURCE_URL := https://www.kernel.org/pub/linux/utils/util-linux/v2.30/util-linux-2.30.1.tar.xz
MD5 := 5e5ec141e775efe36f640e62f3f8cd0d

toolchain:
	@$(STEP) "util-linux 2.30.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/util-linux-2.30.1 && \
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
	./configure \
	--prefix=$(TOOLS_DIR) \
	--sysconfdir=$(TOOLS_DIR)/etc \
	--localstatedir=$(TOOLS_DIR)/var \
	--enable-shared \
	--disable-static \
	--without-python \
	--enable-libblkid \
	--enable-libmount \
	--enable-libuuid \
	--without-ncurses \
	--without-ncursesw \
	--without-tinfo \
	--disable-makeinstall-chown \
	--disable-more )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/util-linux-2.30.1
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/util-linux-2.30.1
	@rm -rf $(BUILD_DIR)/util-linux-2.30.1

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "util-linux 2.29.2"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@mkdir -pv $(ROOTFS_DIR)/var/lib/hwclock
	@( cd $(BUILD_DIR)/util-linux-2.30.1 && \
	PKG_CONFIG="$(TOOLS_DIR)/bin/pkg-config" \
	ac_cv_lbl_unaligned_fail=yes \
	ac_cv_func_mmap_fixed_mapped=yes \
	ac_cv_func_memcmp_working=yes \
	ac_cv_have_decl_malloc=yes \
	gl_cv_func_malloc_0_nonnull=yes \
	ac_cv_func_malloc_0_nonnull=yes \
	ac_cv_func_calloc_0_nonnull=yes \
	ac_cv_func_realloc_0_nonnull=yes \
	lt_cv_sys_lib_search_path_spec="" \
	ac_cv_c_bigendian=no \
	CONFIG_SITE=/dev/null \
	./configure \
	scanf_cv_type_modifier=no \
	LIBS="" \
	CONFIG_SITE=/dev/null \
	ADJTIME_PATH=/var/lib/hwclock/adjtime \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--enable-widechar \
	--without-tinfo \
	--without-ncursesw \
	--without-ncurses \
	--disable-chfn-chsh \
	--disable-rpath \
	--disable-makeinstall-chown \
	--disable-login \
	--disable-nologin \
	--disable-su \
	--disable-setpriv \
	--disable-runuser \
	--disable-pylibmount \
	--disable-static \
	--enable-shared \
	--without-python \
	--enable-libmount-force-mountinfo )
	@make -j$(CONFIG_PARALLEL_JOBS) LIBS="" -C $(BUILD_DIR)/util-linux-2.30.1
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/util-linux-2.30.1
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/util-linux-2.30.1
	@rm -rf $(BUILD_DIR)/util-linux-2.30.1
