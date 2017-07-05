include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/pkg-config-0.29.2.tar.gz
SOURCE_URL := https://pkg-config.freedesktop.org/releases/pkg-config-0.29.2.tar.gz
MD5 := f6e931e319531b736fadc017f470e68a

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "pkg-config 0.29.2"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/pkg-config-0.29.2 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--disable-compile-warnings \
	--disable-host-tool \
	--docdir=/usr/share/doc/pkg-config-0.29.2 )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/pkg-config-0.29.2
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/pkg-config-0.29.2
	@rm -rf $(BUILD_DIR)/pkg-config-0.29.2
