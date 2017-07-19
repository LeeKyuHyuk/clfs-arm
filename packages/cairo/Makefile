include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/cairo-1.14.10.tar.xz
SOURCE_URL := http://cairographics.org/releases/cairo-1.14.10.tar.xz
MD5 := 146f5f4d0b4439fc3792fd3452b7b12a

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "cairo 1.14.10"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@cp -r $(DEVICE_DIR)/raspberrypi/hardfp/opt/vc/include/* $(SYSROOT_DIR)/usr/include/
	@cp -r $(DEVICE_DIR)/raspberrypi/hardfp/opt/vc/lib/* $(SYSROOT_DIR)/usr/lib/
	@( cd $(BUILD_DIR)/cairo-1.14.10 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
 	--prefix=$(SYSROOT_DIR)/usr \
	--disable-static \
	--enable-tee \
	--enable-glesv2 )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/cairo-1.14.10
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/cairo-1.14.10
	@rm -rf $(BUILD_DIR)/cairo-1.14.10

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "cairo 1.14.10"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@cp -r $(DEVICE_DIR)/raspberrypi/hardfp/opt/vc/bin/* $(ROOTFS_DIR)/usr/bin/
	@cp -r $(DEVICE_DIR)/raspberrypi/hardfp/opt/vc/include/* $(ROOTFS_DIR)/usr/include/
	@cp -r $(DEVICE_DIR)/raspberrypi/hardfp/opt/vc/lib/* $(ROOTFS_DIR)/usr/lib/
	@cp -r $(DEVICE_DIR)/raspberrypi/hardfp/opt/vc/sbin/* $(ROOTFS_DIR)/usr/sbin/
	@( cd $(BUILD_DIR)/cairo-1.14.10 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
 	--prefix=/usr \
	--disable-static \
	--enable-tee \
	--enable-glesv2 )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/cairo-1.14.10
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/cairo-1.14.10
	@rm -rf $(BUILD_DIR)/cairo-1.14.10
