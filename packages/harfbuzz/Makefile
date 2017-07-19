include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/harfbuzz-1.4.6.tar.bz2
SOURCE_URL := https://www.freedesktop.org/software/harfbuzz/release/harfbuzz-1.4.6.tar.bz2
MD5 := e246c08a3bac98e31e731b2a1bf97edf

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "harfbuzz 1.4.6"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/harfbuzz-1.4.6 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--disable-static \
	--enable-shared \
	--with-coretext=no \
	--with-uniscribe=no \
	--with-cairo=no \
	--with-freetype=yes \
	--with-graphite2=no \
	--with-glib=yes \
	--with-icu=no )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/harfbuzz-1.4.6
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/harfbuzz-1.4.6
	@rm -rf $(BUILD_DIR)/harfbuzz-1.4.6

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "harfbuzz 1.4.6"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/harfbuzz-1.4.6 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--disable-static \
	--enable-shared \
	--with-coretext=no \
	--with-uniscribe=no \
	--with-cairo=no \
	--with-freetype=yes \
	--with-graphite2=no \
	--with-glib=yes \
	--with-icu=no )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/harfbuzz-1.4.6
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/harfbuzz-1.4.6
	@rm -rf $(BUILD_DIR)/harfbuzz-1.4.6
