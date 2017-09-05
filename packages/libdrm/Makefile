include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/libdrm-2.4.82.tar.bz2
SOURCE_URL := http://dri.freedesktop.org/libdrm/libdrm-2.4.82.tar.bz2
MD5 := 29867814123c3d23056b1d05aada1b9d

toolchain:
	@$(STEP) "libdrm 2.4.82"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/libdrm-2.4.82 && \
	CFLAGS="-O2 -I$(TOOLS_DIR)/include" \
	CPPFLAGS="-I$(TOOLS_DIR)/include" \
	CXXFLAGS="-O2 -I$(TOOLS_DIR)/include" \
	LDFLAGS="-L$(TOOLS_DIR)/lib -L$(TOOLS_DIR)/lib -Wl,-rpath,$(TOOLS_DIR)/lib" \
	PKG_CONFIG="$(TOOLS_DIR)/bin/pkg-config" \
	PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/lib/pkgconfig:$(TOOLS_DIR)/share/pkgconfig" \
	PKG_CONFIG_SYSROOT_DIR="/" \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
	./configure \
	--prefix=$(TOOLS_DIR) \
	--sysconfdir=$(TOOLS_DIR)/etc \
	--localstatedir=$(TOOLS_DIR)/var \
	--disable-static \
	--enable-udev )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/libdrm-2.4.82
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/libdrm-2.4.82
	@rm -rf $(BUILD_DIR)/libdrm-2.4.82

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "libdrm 2.4.82"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/libdrm/Add-ARM-support-into-xf86drm.h.patch -d $(BUILD_DIR)/libdrm-2.4.82
	@patch -Np1 -i $(PACKAGES_DIR)/libdrm/xf86atomic-require-CAS-support-in-libatomic_ops.patch -d $(BUILD_DIR)/libdrm-2.4.82
	@( cd $(BUILD_DIR)/libdrm-2.4.82 && \
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
	ac_cv_prog_cc_c99='-std=gnu99' \
	CONFIG_SITE=/dev/null \
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
	--disable-cairo-tests \
	--disable-manpages \
	--disable-intel \
	--disable-radeon \
	--disable-amdgpu \
	--disable-nouveau \
	--disable-vmwgfx \
	--disable-omap-experimental-api \
	--disable-etnaviv-experimental-api \
	--disable-exynos-experimental-api \
	--disable-freedreno \
	--disable-tegra-experimental-api \
	--enable-vc4 \
	--enable-udev \
	--disable-valgrind )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/libdrm-2.4.82
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/libdrm-2.4.82
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/libdrm-2.4.82
	@rm -rf $(BUILD_DIR)/libdrm-2.4.82
