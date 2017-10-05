include $(SUPPORT_DIR)/functions.mk

NAME := lsb-release
SOURCE := $(SOURCES_DIR)/lsb-release-1.4.tar.gz
SOURCE_URL := https://downloads.sourceforge.net/lsb/lsb-release-1.4.tar.gz
MD5 := 30537ef5a01e0ca94b7b8eb6a36bb1e4

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "lsb-release 1.4"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -i "s|n/a|unavailable|" $(BUILD_DIR)/lsb-release-1.4/lsb_release
	@install -v -m 755 $(BUILD_DIR)/lsb-release-1.4/lsb_release $(ROOTFS_DIR)/usr/bin/lsb_release
	@cp -v $(PACKAGES_DIR)/lsb_release/lsb-release $(ROOTFS_DIR)/etc/lsb-release
	@rm -rf $(BUILD_DIR)/lsb-release-1.4
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
