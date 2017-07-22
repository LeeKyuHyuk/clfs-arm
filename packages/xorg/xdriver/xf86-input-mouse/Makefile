include $(SUPPORT_DIR)/functions.mk

SOURCE := $(PACKAGES_DIR)/xorg/xdriver/xf86-input-mouse/xf86-input-mouse-1.9.2.tar.bz2
SOURCE_URL := https://www.x.org/releases/individual/driver/xf86-input-mouse-1.9.2.tar.bz2
MD5 := ce2d679283a22c8e0dccdd9248594845

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/xf86-input-mouse-1.9.2 && autoconf )
	@( cd $(BUILD_DIR)/xf86-input-mouse-1.9.2 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--sysconfdir=$(SYSROOT_DIR)/etc \
	--localstatedir=$(SYSROOT_DIR)/var \
	--disable-static \
	--enable-malloc0returnsnull )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/xf86-input-mouse-1.9.2
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/xf86-input-mouse-1.9.2
	@mkdir -pv $(SYSROOT_DIR)/usr/share/X11/xorg.conf.d
	@install -c -m 644 $(BUILD_DIR)/xf86-input-mouse-1.9.2/xorg-mouse.pc $(SYSROOT_DIR)/usr/lib/pkgconfig
	@rm -rf $(BUILD_DIR)/xf86-input-mouse-1.9.2

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/xf86-input-mouse-1.9.2 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--sysconfdir=$(SYSROOT_DIR)/etc \
	--localstatedir=$(SYSROOT_DIR)/var \
	--disable-static \
	--enable-malloc0returnsnull )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/xf86-input-mouse-1.9.2
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/xf86-input-mouse-1.9.2
	@mkdir -pv $(SYSROOT_DIR)/usr/share/X11/xorg.conf.d
	@install -c -m 644 $(BUILD_DIR)/xf86-input-mouse-1.9.2/xorg-mouse.pc $(ROOTFS_DIR)/usr/lib/pkgconfig
	@rm -rf $(BUILD_DIR)/xf86-input-mouse-1.9.2
