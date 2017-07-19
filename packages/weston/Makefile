include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/weston-2.0.0.tar.xz
SOURCE_URL := https://wayland.freedesktop.org/releases/weston-2.0.0.tar.xz
MD5 := 15f38945942bf2a91fe2687145fb4c7d

staging:
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
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
 	--prefix=$(SYSROOT_DIR)/usr \
	--sysconfdir=$(SYSROOT_DIR)/etc \
	--localstatedir=$(SYSROOT_DIR)/var \
	--disable-egl \
	--disable-xwayland \
	--disable-x11-compositor \
	--disable-drm-compositor \
	--disable-weston-launch \
	--enable-demo-clients-install \
	WESTON_NATIVE_BACKEND="fbdev-backend.so" )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/weston-2.0.0
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/weston-2.0.0
	@rm -rf $(BUILD_DIR)/weston-2.0.0

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
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
 	--prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--disable-egl \
	--disable-xwayland \
	--disable-x11-compositor \
	--disable-drm-compositor \
	--disable-weston-launch \
	--enable-demo-clients-install \
	WESTON_NATIVE_BACKEND="fbdev-backend.so" )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/weston-2.0.0
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/weston-2.0.0
	@echo "/run/shm/wayland dir 1700 root root" >> $(ROOTFS_DIR)/etc/sysconfig/createfiles
	@echo "export XDG_RUNTIME_DIR=/run/shm/wayland" >> $(ROOTFS_DIR)/etc/profile
	@rm -rf $(BUILD_DIR)/weston-2.0.0
