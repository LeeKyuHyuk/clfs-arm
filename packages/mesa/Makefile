include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/mesa-17.1.5.tar.xz
SOURCE_URL := https://mesa.freedesktop.org/archive/mesa-17.1.5.tar.xz
MD5 := 6cf936fbcaadd98924298a7009e8265d

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "mesa 17.1.5"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/mesa/configure.ac-invert-order-for-wayland-scanner-check.patch -d $(BUILD_DIR)/mesa-17.1.5
	@( cd $(BUILD_DIR)/mesa-17.1.5 && autoconf )
	@( cd $(BUILD_DIR)/mesa-17.1.5 && \
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
	--disable-asm \
	--enable-glx \
	--disable-mangling \
	--enable-xa \
	--enable-shared-glapi \
	--with-gallium-drivers=vc4 \
	--enable-gallium-extra-hud \
	--without-dri-drivers \
	--disable-dri3 \
	--without-vulkan-drivers \
	--disable-osmesa \
	--enable-opengl \
	--enable-dri \
	--disable-va \
	--with-platforms=drm,wayland,x11 \
	--enable-gbm \
	--enable-egl \
	--enable-gles1 \
	--enable-gles2 \
	--disable-texture-float \
	--disable-xvmc \
	--disable-libunwind \
	--disable-vdpau \
	--disable-lmsensors \
	--with-llvm-prefix=$(SYSROOT_DIR)/usr/bin )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/mesa-17.1.5
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/mesa-17.1.5
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/mesa-17.1.5
	@rm -rf $(BUILD_DIR)/mesa-17.1.5
