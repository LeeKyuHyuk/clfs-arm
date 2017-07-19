include $(SUPPORT_DIR)/functions.mk

SOURCE := $(PACKAGES_DIR)/eudev/eudev-3.2.2.tar.gz
SOURCE_URL := https://dev.gentoo.org/~blueness/eudev/eudev-3.2.2.tar.gz
MD5 := 41e19b70462692fefd072a3f38818b6e

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "eudev 3.2.2"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/eudev-3.2.2 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--disable-static )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/eudev-3.2.2
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/eudev-3.2.2
	@rm -rf $(BUILD_DIR)/eudev-3.2.2

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "eudev 3.2.2"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/eudev-3.2.2 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--bindir=/sbin \
	--sbindir=/sbin \
	--libdir=/usr/lib \
	--sysconfdir=/etc \
	--libexecdir=/lib \
	--with-rootprefix= \
	--with-rootlibdir=/lib \
	--enable-manpages \
	--disable-static \
	--config-cache )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/eudev-3.2.2
	@mkdir -pv $(ROOTFS_DIR)/lib/udev/rules.d
	@mkdir -pv $(ROOTFS_DIR)/etc/udev/rules.d
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/eudev-3.2.2
	@tar -jxf $(PACKAGES_DIR)/udev/udev-lfs-20140408.tar.bz2 -C $(BUILD_DIR)/eudev-3.2.2
	@( cd $(BUILD_DIR)/eudev-3.2.2 && make -f udev-lfs-20140408/Makefile.lfs DESTDIR=$(ROOTFS_DIR) install )
	@rm -rf $(BUILD_DIR)/eudev-3.2.2
