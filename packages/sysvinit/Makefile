include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/sysvinit-2.88dsf.tar.bz2
SOURCE_URL := http://download.savannah.gnu.org/releases/sysvinit/sysvinit-2.88dsf.tar.bz2
MD5 := 6eda8a97b86e0a6f59dabbf25202aa6f

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "sysvinit 2.88dsf"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/sysvinit/sysvinit-2.88dsf-consolidated-1.patch -d $(BUILD_DIR)/sysvinit-2.88dsf
	@make -j$(CONFIG_PARALLEL_JOBS) CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc -C $(BUILD_DIR)/sysvinit-2.88dsf/src
	@make -j$(CONFIG_PARALLEL_JOBS) ROOT=$(ROOTFS_DIR) install -C $(BUILD_DIR)/sysvinit-2.88dsf/src
	@rm -rf $(BUILD_DIR)/sysvinit-2.88dsf
