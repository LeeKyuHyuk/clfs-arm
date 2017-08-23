include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/gstreamer-1.12.2.tar.xz
SOURCE_URL := https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.12.2.tar.xz
MD5 := 4748860621607ffd96244fb79c86c238

toolchain:
	@$(STEP) "gstreamer 1.12.2"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/gstreamer-1.12.2 && \
	PKG_CONFIG="$(TOOLS_DIR)/usr/bin/pkg-config" \
	PKG_CONFIG_SYSROOT_DIR="/" \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
	PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/usr/lib/pkgconfig:$(TOOLS_DIR)/usr/share/pkgconfig" \
	CPPFLAGS="-I$(TOOLS_DIR)/usr/include" \
	CFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
	CXXFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
	LDFLAGS="-L$(TOOLS_DIR)/usr/lib -Wl,-rpath,$(TOOLS_DIR)/usr/lib" \
	CONFIG_SITE=/dev/null \
	./configure \
	--prefix=$(TOOLS_DIR)/usr \
	--sysconfdir=$(TOOLS_DIR)/etc \
	--localstatedir=$(TOOLS_DIR)/var \
	--enable-shared \
	--disable-static )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/gstreamer-1.12.2
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/gstreamer-1.12.2
	@rm -rf $(BUILD_DIR)/gstreamer-1.12.2

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "gstreamer 1.12.2"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/gstreamer-1.12.2 && \
	PKG_CONFIG="$(TOOLS_DIR)/usr/bin/pkg-config" \
	PKG_CONFIG_LIBDIR=$(SYSROOT_DIR)/usr/lib/pkgconfig:$(SYSROOT_DIR)/usr/share/pkgconfig \
	PKG_CONFIG_SYSROOT_DIR=$(SYSROOT_DIR) \
	CFLAGS="--sysroot=$(SYSROOT_DIR)" \
	CPPFLAGS="--sysroot=$(SYSROOT_DIR)" \
	OBJCFLAGS="--sysroot=$(SYSROOT_DIR)" \
	CXXFLAGS="--sysroot=$(SYSROOT_DIR)" \
	LDFLAGS="--sysroot=$(SYSROOT_DIR)" \
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
	./autogen.sh \
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
	--disable-gtk-doc \
	--disable-benchmarks \
	--disable-debug \
	--disable-examples \
	--disable-tests \
	--disable-failing-tests \
	--disable-loadsave \
	--disable-gst-debug \
	--with-package-name="$(CONFIG_PKG_VERSION)" \
	--with-package-origin="$(CONFIG_BUG_URL)" )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/gstreamer-1.12.2
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/gstreamer-1.12.2
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/gstreamer-1.12.2
	@rm -rf $(BUILD_DIR)/gstreamer-1.12.2
