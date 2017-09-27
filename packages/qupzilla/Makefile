include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/QupZilla-2.1.2.tar.xz
SOURCE_URL := https://github.com/QupZilla/qupzilla/releases/download/v2.1.2/QupZilla-2.1.2.tar.xz
MD5 := 84e4b9dda1e0bb5ad96f3b87f9fc1328

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "QupZilla 2.1.2"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/qupzilla/qupzilla-2.1.2-openssl1.1-1.patch -d $(BUILD_DIR)/QupZilla-2.1.2
	@( cd $(BUILD_DIR)/QupZilla-2.1.2 && qmake )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/QupZilla-2.1.2
	@make -j$(CONFIG_PARALLEL_JOBS) INSTALL_ROOT=$(ROOTFS_DIR) install -C $(BUILD_DIR)/QupZilla-2.1.2
	@rm -rf $(BUILD_DIR)/QupZilla-2.1.2
