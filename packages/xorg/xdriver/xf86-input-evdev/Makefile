include $(SUPPORT_DIR)/functions.mk

SOURCE := $(PACKAGES_DIR)/xorg/xdriver/xf86-input-evdev/xf86-input-evdev-2.10.5.tar.bz2
SOURCE_URL := https://www.x.org/releases/individual/driver/xf86-input-evdev-2.10.5.tar.bz2
MD5 := 94c2c8354c74ab1cfbbb0a222078b9c6

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
	@patch -Np1 -i $(PACKAGES_DIR)/xorg/xdriver/xf86-input-evdev/build-get-rid-of-sdkdir.patch -d $(BUILD_DIR)/xf86-input-evdev-2.10.5
	@( cd $(BUILD_DIR)/xf86-input-evdev-2.10.5 && autoconf )
	@( cd $(BUILD_DIR)/xf86-input-evdev-2.10.5 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--sysconfdir=$(SYSROOT_DIR)/etc \
	--localstatedir=$(SYSROOT_DIR)/var \
	--disable-static \
	--enable-malloc0returnsnull )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/xf86-input-evdev-2.10.5
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/xf86-input-evdev-2.10.5
	@mkdir -pv $(SYSROOT_DIR)/usr/share/X11/xorg.conf.d
	@install -c -m 644 $(BUILD_DIR)/xf86-input-evdev-2.10.5/10-evdev.conf $(SYSROOT_DIR)/usr/share/X11/xorg.conf.d
	@install -c -m 644 $(BUILD_DIR)/xf86-input-evdev-2.10.5/xorg-evdev.pc $(SYSROOT_DIR)/usr/lib/pkgconfig
	@rm -rf $(BUILD_DIR)/xf86-input-evdev-2.10.5

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
	@patch -Np1 -i $(PACKAGES_DIR)/xorg/xdriver/xf86-input-evdev/build-get-rid-of-sdkdir.patch -d $(BUILD_DIR)/xf86-input-evdev-2.10.5
	@( cd $(BUILD_DIR)/xf86-input-evdev-2.10.5 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--sysconfdir=$(SYSROOT_DIR)/etc \
	--localstatedir=$(SYSROOT_DIR)/var \
	--disable-static \
	--enable-malloc0returnsnull )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/xf86-input-evdev-2.10.5
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/xf86-input-evdev-2.10.5
	@mkdir -pv $(ROOTFS_DIR)/usr/share/X11/xorg.conf.d
	@install -c -m 644 $(BUILD_DIR)/xf86-input-evdev-2.10.5/10-evdev.conf $(ROOTFS_DIR)/usr/share/X11/xorg.conf.d
	@install -c -m 644 $(BUILD_DIR)/xf86-input-evdev-2.10.5/xorg-evdev.pc $(ROOTFS_DIR)/usr/lib/pkgconfig
	@rm -rf $(BUILD_DIR)/xf86-input-evdev-2.10.5
