include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/busybox-1.27.1.tar.bz2
SOURCE_URL := http://busybox.net/downloads/busybox-1.27.1.tar.bz2
MD5 := df7e45d07634c54ca16b9191635db9c6

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "Busybox 1.27.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/busybox/networking-libiproute-use-linux-if_packet.h-instead-.patch -d $(BUILD_DIR)/busybox-1.27.1
	@patch -Np1 -i $(PACKAGES_DIR)/busybox/Makefile.flags-strip-non-l-arguments-returned-by-pkg.patch -d $(BUILD_DIR)/busybox-1.27.1
	@patch -Np1 -i $(PACKAGES_DIR)/busybox/Makefile-include-per-arch-Makefile-before-Makefile.f.patch -d $(BUILD_DIR)/busybox-1.27.1
	@cp -v $(PACKAGES_DIR)/busybox/busybox.config $(BUILD_DIR)/busybox-1.27.1/.config
	@sed -i -e 's/^noclobber="0"$$/noclobber="1"/' $(BUILD_DIR)/busybox-1.27.1/applets/install.sh
	@CFLAGS_busybox="" make -j$(CONFIG_PARALLEL_JOBS) CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc ARCH=$(CONFIG_MODE) PREFIX=$(ROOTFS_DIR) EXTRA_LDFLAGS="" CROSS_COMPILE=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)- CONFIG_PREFIX=$(ROOTFS_DIR) SKIP_STRIP=y -C $(BUILD_DIR)/busybox-1.27.1
	@CFLAGS_busybox="" make -j$(CONFIG_PARALLEL_JOBS) CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc ARCH=$(CONFIG_MODE) PREFIX=$(ROOTFS_DIR) EXTRA_LDFLAGS="" CROSS_COMPILE=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)- CONFIG_PREFIX=$(ROOTFS_DIR) SKIP_STRIP=y -C $(BUILD_DIR)/busybox-1.27.1 install
	@install -Dv -m 0644 $(PACKAGES_DIR)/busybox/inittab $(ROOTFS_DIR)/etc/inittab
	@install -Dv -m 0755 $(PACKAGES_DIR)/busybox/udhcpc.script $(ROOTFS_DIR)/usr/share/udhcpc/default.script
	@install -d -m 0755 $(ROOTFS_DIR)/usr/share/udhcpc/default.script.d
	@install -Dv -m 0755 $(PACKAGES_DIR)/busybox/S01logging $(ROOTFS_DIR)/etc/init.d/S01logging
	@rm -rf $(BUILD_DIR)/busybox-1.27.1
