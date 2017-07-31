include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/json-c-0.12.1-20160607.tar.gz
SOURCE_URL := https://github.com/json-c/json-c/archive/json-c-0.12.1-20160607.tar.gz
MD5 := 0a2a49a1e89044fdac414f984f3f81a6

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "JSON-C 0.12.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -i s/-Werror// $(BUILD_DIR)/json-c-json-c-0.12.1-20160607/Makefile.in $(BUILD_DIR)/json-c-json-c-0.12.1-20160607/tests/Makefile.in
	@( cd $(BUILD_DIR)/json-c-json-c-0.12.1-20160607 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--disable-static )
	@make -j1 -C $(BUILD_DIR)/json-c-json-c-0.12.1-20160607
	@make -j1 install -C $(BUILD_DIR)/json-c-json-c-0.12.1-20160607
	@rm -rf $(BUILD_DIR)/json-c-json-c-0.12.1-20160607

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "JSON-C 0.12.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -i s/-Werror// $(BUILD_DIR)/json-c-json-c-0.12.1-20160607/Makefile.in $(BUILD_DIR)/json-c-json-c-0.12.1-20160607/tests/Makefile.in
	@( cd $(BUILD_DIR)/json-c-json-c-0.12.1-20160607 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--disable-static )
	@make -j1 -C $(BUILD_DIR)/json-c-json-c-0.12.1-20160607
	@make -j1 DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/json-c-json-c-0.12.1-20160607
	@rm -rf $(BUILD_DIR)/json-c-json-c-0.12.1-20160607
