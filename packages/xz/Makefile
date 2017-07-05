include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/xz-5.2.3.tar.xz
SOURCE_URL := http://tukaani.org/xz/xz-5.2.3.tar.xz
MD5 := 60fb79cab777e3f71ca43d298adacbd5

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "xz 5.2.3"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/xz-5.2.3 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--disable-static )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/xz-5.2.3
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/xz-5.2.3
	@rm -rf $(BUILD_DIR)/xz-5.2.3

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "xz 5.2.3"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/xz-5.2.3 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--disable-static \
	--docdir=/usr/share/doc/xz-5.2.3 )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/xz-5.2.3
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/xz-5.2.3
	@mv -v $(ROOTFS_DIR)/usr/bin/lzma $(ROOTFS_DIR)/bin
	@mv -v $(ROOTFS_DIR)/usr/bin/unlzma $(ROOTFS_DIR)/bin
	@mv -v $(ROOTFS_DIR)/usr/bin/lzcat $(ROOTFS_DIR)/bin
	@mv -v $(ROOTFS_DIR)/usr/bin/xz $(ROOTFS_DIR)/bin
	@mv -v $(ROOTFS_DIR)/usr/bin/unxz $(ROOTFS_DIR)/bin
	@mv -v $(ROOTFS_DIR)/usr/bin/xzcat $(ROOTFS_DIR)/bin
	@mv -v $(ROOTFS_DIR)/usr/lib/liblzma.so.* $(ROOTFS_DIR)/lib
	@ln -svf ../../lib/`readlink $(ROOTFS_DIR)/usr/lib/liblzma.so` $(ROOTFS_DIR)/usr/lib/liblzma.so
	@rm -rf $(BUILD_DIR)/xz-5.2.3
