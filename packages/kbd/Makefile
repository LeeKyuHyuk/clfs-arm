include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/kbd-2.0.4.tar.xz
SOURCE_URL := https://www.kernel.org/pub/linux/utils/kbd/kbd-2.0.4.tar.xz
MD5 := c240bfb7de57160115be343ec4c83bfe

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "kbd 2.0.4"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/kbd/kbd-2.0.4-backspace-1.patch -d $(BUILD_DIR)/kbd-2.0.4
	@sed -i 's/\(RESIZECONS_PROGS=\)yes/\1no/g' $(BUILD_DIR)/kbd-2.0.4/configure
	@sed -i 's/resizecons.8 //' $(BUILD_DIR)/kbd-2.0.4/docs/man/man8/Makefile.in
	@( cd $(BUILD_DIR)/kbd-2.0.4 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--disable-vlock )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/kbd-2.0.4
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/kbd-2.0.4
	@rm -rf $(BUILD_DIR)/kbd-2.0.4
