include $(SUPPORT_DIR)/functions.mk

SOURCE := $(PACKAGES_DIR)/wireless-tools/wireless_tools.29.tar.gz
SOURCE_URL := http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/wireless_tools.29.tar.gz
MD5 := e06c222e186f7cc013fd272d023710cb

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "wireless tools 29"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/wireless-tools/wireless_tools-29-fix_iwlist_scanning-1.patch -d $(BUILD_DIR)/wireless_tools.29
	@make -j$(CONFIG_PARALLEL_JOBS) CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib -C $(BUILD_DIR)/wireless_tools.29
	@make -j$(CONFIG_PARALLEL_JOBS) CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib PREFIX=$(SYSROOT_DIR)/usr install -C $(BUILD_DIR)/wireless_tools.29
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib PREFIX=$(ROOTFS_DIR)/usr install -C $(BUILD_DIR)/wireless_tools.29
	@rm -rf $(BUILD_DIR)/wireless_tools.29
