include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/cairo-1.14.10.tar.xz
SOURCE_URL := http://cairographics.org/releases/cairo-1.14.10.tar.xz
MD5 := 146f5f4d0b4439fc3792fd3452b7b12a

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "cairo 1.14.10"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/cairo-1.14.10 && \
	PKG_CONFIG="$(TOOLS_DIR)/usr/bin/pkg-config" \
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
	LIBS="-latomic" \
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
	--enable-trace=no \
	--enable-interpreter=no \
	--disable-directfb \
	--enable-ft \
	--disable-gobject \
	--enable-gl \
	--disable-glesv2 \
	--disable-vg \
	--enable-xlib \
	--enable-xcb \
	--with-x \
	--enable-xlib-xrender \
	--disable-ps \
	--disable-pdf \
	--enable-png \
	--disable-script \
	--disable-svg \
	--disable-tee \
	--disable-xml )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/cairo-1.14.10
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/cairo-1.14.10
	@$(call dependency_libs_patch)
	@sed -i "s@\.latomic@\-latomic@g" $(SYSROOT_DIR)/usr/lib/libcairo.la
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/cairo-1.14.10
	@sed -i "s@\.latomic@\-latomic@g" $(ROOTFS_DIR)/usr/lib/libcairo.la
	@rm -rf $(BUILD_DIR)/cairo-1.14.10
