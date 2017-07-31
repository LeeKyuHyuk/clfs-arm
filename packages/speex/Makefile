include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/speex-1.2rc2.tar.gz
SOURCE_URL := http://downloads.xiph.org/releases/speex/speex-1.2rc2.tar.gz
MD5 := 6ae7db3bab01e1d4b86bacfa8ca33e81

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "speex 1.2rc2"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/speex-1.2rc2 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--disable-static )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/speex-1.2rc2
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/speex-1.2rc2
	@rm -rf $(BUILD_DIR)/speex-1.2rc2

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "speex 1.2rc2"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/speex-1.2rc2 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--disable-static \
	--docdir=/usr/share/doc/speex-1.2rc2 )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/speex-1.2rc2
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/speex-1.2rc2
	@rm -rf $(BUILD_DIR)/speex-1.2rc2
