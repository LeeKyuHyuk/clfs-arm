include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/weston-2.0.0.tar.xz
SOURCE_URL := https://wayland.freedesktop.org/releases/weston-2.0.0.tar.xz
MD5 := 15f38945942bf2a91fe2687145fb4c7d


system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "weston 2.0.0"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/weston-2.0.0 && \
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
	LIBS="" \
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
	--with-dtddir=$(SYSROOT_DIR)/usr/share/wayland \
	--disable-headless-compositor \
	--disable-colord \
	--disable-devdocs \
	--disable-setuid-install \
	--enable-dbus \
	--enable-egl \
	--disable-libunwind \
	--disable-rdp-compositor \
	--enable-fbdev-compositor \
	--disable-drm-compositor \
	--disable-x11-compositor \
	--enable-xwayland \
	--disable-vaapi-recorder \
	--disable-lcms \
	--disable-systemd-login \
	--disable-systemd-notify \
	--enable-junit-xml \
	--disable-demo-clients-install \
	WESTON_NATIVE_BACKEND=fbdev-backend.so )
	@make -j$(CONFIG_PARALLEL_JOBS) WAYLAND_PROTOCOLS_DATADIR=$(SYSROOT_DIR)/usr/share/wayland-protocols -C $(BUILD_DIR)/weston-2.0.0
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/weston-2.0.0
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/weston-2.0.0
	@echo "/run/shm/wayland dir 1700 root root" >> $(ROOTFS_DIR)/etc/sysconfig/createfiles
	@echo "export XDG_RUNTIME_DIR=/run/shm/wayland" >> $(ROOTFS_DIR)/etc/profile
	@rm -rf $(BUILD_DIR)/weston-2.0.0
