include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/libepoxy-1.4.3.tar.xz
SOURCE_URL := https://github.com/anholt/libepoxy/releases/download/1.4.3/libepoxy-1.4.3.tar.xz
MD5 := af4c3ce0fb1143bdc4e43f85695a9bed

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "libepoxy 1.4.3"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/libepoxy-1.4.3 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--libdir=$(SYSROOT_DIR)/usr/lib \
	--sysconfdir=$(SYSROOT_DIR)/etc )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/libepoxy-1.4.3
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/libepoxy-1.4.3
	@rm -rf $(BUILD_DIR)/libepoxy-1.4.3

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "libepoxy 1.4.3"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/libepoxy-1.4.3 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--libdir=/usr/lib \
	--sysconfdir=/etc )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/libepoxy-1.4.3
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/libepoxy-1.4.3
	@rm -rf $(BUILD_DIR)/libepoxy-1.4.3
