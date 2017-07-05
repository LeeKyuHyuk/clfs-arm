include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/e2fsprogs-1.43.4.tar.gz
SOURCE_URL := http://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v1.43.4/e2fsprogs-1.43.4.tar.gz
MD5 := 0bd1c74f357f6e9ae2ab6fa6229b9aea

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "e2fsprogs 1.43.4"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/e2fsprogs-1.43.4 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--bindir=/bin \
	--with-root-prefix="" \
	--enable-elf-shlibs \
	--disable-libblkid \
	--disable-libuuid \
	--disable-uuidd \
	--disable-fsck )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/e2fsprogs-1.43.4
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/e2fsprogs-1.43.4
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install-libs -C $(BUILD_DIR)/e2fsprogs-1.43.4
	@chmod -v u+w $(ROOTFS_DIR)/usr/lib/libcom_err.a
	@chmod -v u+w $(ROOTFS_DIR)/usr/lib/libe2p.a
	@chmod -v u+w $(ROOTFS_DIR)/usr/lib/libext2fs.a
	@chmod -v u+w $(ROOTFS_DIR)/usr/lib/libss.a
	@rm -rf $(BUILD_DIR)/e2fsprogs-1.43.4
