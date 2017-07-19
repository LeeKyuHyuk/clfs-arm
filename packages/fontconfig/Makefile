include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/fontconfig-2.12.4.tar.gz
SOURCE_URL := https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.12.4.tar.gz
MD5 := 4fb01fc3f41760c41c69e37cc784b658

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "fontconfig 2.12.4"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@rm -vf $(BUILD_DIR)/fontconfig-2.12.4/src/fcobjshash.h
	@( cd $(BUILD_DIR)/fontconfig-2.12.4 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--sysconfdir=$(SYSROOT_DIR)/etc \
	--localstatedir=$(SYSROOT_DIR)/var \
	--enable-libxml2 \
	--with-arch=$(CONFIG_TARGET) \
	--disable-docs )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/fontconfig-2.12.4
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/fontconfig-2.12.4
	@rm -rf $(BUILD_DIR)/fontconfig-2.12.4

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "fontconfig 2.12.4"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@rm -vf $(BUILD_DIR)/fontconfig-2.12.4/src/fcobjshash.h
	@( cd $(BUILD_DIR)/fontconfig-2.12.4 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--docdir=/usr/share/doc/fontconfig-2.12.4 \
	--enable-libxml2 \
	--with-arch=$(CONFIG_TARGET) \
	--disable-docs )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/fontconfig-2.12.4
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/fontconfig-2.12.4
	@rm -rf $(BUILD_DIR)/fontconfig-2.12.4
