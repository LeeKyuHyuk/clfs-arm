include $(SUPPORT_DIR)/functions.mk

SOURCE := $(PACKAGES_DIR)/lsb-release/lsb-release-1.4.tar.gz
SOURCE_URL := http://sourceforge.net/projects/lsb/files/lsb_release/1.4/lsb-release-1.4.tar.gz
MD5 := 30537ef5a01e0ca94b7b8eb6a36bb1e4

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "lsb-release 1.4"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@install -v -m 755 $(BUILD_DIR)/lsb-release-1.4/lsb_release $(ROOTFS_DIR)/usr/bin/lsb_release
	@sed -i "s|n/a|unavailable|" $(ROOTFS_DIR)/usr/bin/lsb_release
	@rm -rf $(BUILD_DIR)/lsb-release-1.4
