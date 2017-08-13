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
	@make distclean -C $(BUILD_DIR)/busybox-1.27.1
	@make ARCH=$(CONFIG_MODE) defconfig -C $(BUILD_DIR)/busybox-1.27.1
	@sed -i 's/\(CONFIG_\)\(.*\)\(INETD\)\(.*\)=y/# \1\2\3\4 is not set/g' $(BUILD_DIR)/busybox-1.27.1/.config
	@sed -i 's/\(CONFIG_IFPLUGD\)=y/# \1 is not set/' $(BUILD_DIR)/busybox-1.27.1/.config
	@sed -i 's/\(CONFIG_FEATURE_WTMP\)=y/# \1 is not set/' $(BUILD_DIR)/busybox-1.27.1/.config
	@sed -i 's/\(CONFIG_FEATURE_UTMP\)=y/# \1 is not set/' $(BUILD_DIR)/busybox-1.27.1/.config
	@sed -i 's/\(CONFIG_UDPSVD\)=y/# \1 is not set/' $(BUILD_DIR)/busybox-1.27.1/.config
	@sed -i 's/\(CONFIG_TCPSVD\)=y/# \1 is not set/' $(BUILD_DIR)/busybox-1.27.1/.config
	@make ARCH=$(CONFIG_MODE) CROSS_COMPILE=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)- -C $(BUILD_DIR)/busybox-1.27.1
	@make ARCH=$(CONFIG_MODE) CROSS_COMPILE=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)- CONFIG_PREFIX=$(ROOTFS_DIR) install -C $(BUILD_DIR)/busybox-1.27.1
	@cp -v $(BUILD_DIR)/busybox-1.27.1/examples/depmod.pl $(TOOLS_DIR)/usr/bin
	@chmod -v 755 $(TOOLS_DIR)/usr/bin/depmod.pl
	@rm -rf $(BUILD_DIR)/busybox-1.27.1
