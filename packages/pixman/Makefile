include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/pixman-0.34.0.tar.gz
SOURCE_URL := http://cairographics.org/releases/pixman-0.34.0.tar.gz
MD5 := e80ebae4da01e77f68744319f01d52a3

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "pixman 0.34.0"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/pixman-0.34.0 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--disable-static \
	--disable-arm-iwmmxt )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/pixman-0.34.0
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/pixman-0.34.0
	@rm -rf $(BUILD_DIR)/pixman-0.34.0

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "pixman 0.34.0"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/pixman-0.34.0 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
 	--prefix=/usr \
	--disable-static \
	--disable-arm-iwmmxt )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/pixman-0.34.0
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/pixman-0.34.0
	@rm -rf $(BUILD_DIR)/pixman-0.34.0
