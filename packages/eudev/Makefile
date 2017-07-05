include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/eudev-3.2.1.tar.gz
SOURCE_URL := http://dev.gentoo.org/~blueness/eudev/eudev-3.2.1.tar.gz
MD5 := 49f71f6c271ffa95b3c20d757d45c2e5

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "eudev 3.2.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/eudev-3.2.1 && \
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
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/eudev-3.2.1
	@mkdir -pv $(ROOTFS_DIR)/lib/udev/rules.d
	@mkdir -pv $(ROOTFS_DIR)/etc/udev/rules.d
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/eudev-3.2.1
	@tar -jxf $(PACKAGES_DIR)/udev/udev-lfs-20140408.tar.bz2 -C $(BUILD_DIR)/eudev-3.2.1
	@( cd $(BUILD_DIR)/eudev-3.2.1 && make -f udev-lfs-20140408/Makefile.lfs DESTDIR=$(ROOTFS_DIR) install )
	@rm -rf $(BUILD_DIR)/eudev-3.2.1
