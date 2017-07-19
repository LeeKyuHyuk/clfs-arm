include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/freetype-2.8.tar.bz2
SOURCE_URL := http://downloads.sourceforge.net/freetype/freetype-2.8.tar.bz2
MD5 := 2413ac3eaf508ada019c63959ea81a92

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "freetype 2.8"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -ri "s:.*(AUX_MODULES.*valid):\1:" $(BUILD_DIR)/freetype-2.8/modules.cfg
	@sed -r "s:.*(#.*SUBPIXEL_RENDERING) .*:\1:" -i $(BUILD_DIR)/freetype-2.8/include/freetype/config/ftoption.h
	@( cd $(BUILD_DIR)/freetype-2.8 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--disable-static )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/freetype-2.8
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/freetype-2.8
	@rm -rf $(BUILD_DIR)/freetype-2.8

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "freetype 2.8"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -ri "s:.*(AUX_MODULES.*valid):\1:" $(BUILD_DIR)/freetype-2.8/modules.cfg
	@sed -r "s:.*(#.*SUBPIXEL_RENDERING) .*:\1:" -i $(BUILD_DIR)/freetype-2.8/include/freetype/config/ftoption.h
	@( cd $(BUILD_DIR)/freetype-2.8 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--disable-static )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/freetype-2.8
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/freetype-2.8
	@rm -rf $(BUILD_DIR)/freetype-2.8
