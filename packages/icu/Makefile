include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/icu4c-59_1-src.tgz
SOURCE_URL := http://download.icu-project.org/files/icu4c/59.1/icu4c-59_1-src.tgz
MD5 := 54923fa9fab5b2b83f235fb72523de37

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "icu4c 59.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@mkdir -pv $(BUILD_DIR)/icu/source/host
	@( cd $(BUILD_DIR)/icu/source/host && ../configure )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/icu/source/host
	@( cd $(BUILD_DIR)/icu/source && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--with-cross-build=$(BUILD_DIR)/icu/source/host )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/icu/source
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/icu/source
	@rm -rf $(BUILD_DIR)/icu

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "icu4c 59.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@mkdir -pv $(BUILD_DIR)/icu/source/host
	@( cd $(BUILD_DIR)/icu/source/host && ../configure )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/icu/source/host
	@( cd $(BUILD_DIR)/icu/source && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--with-cross-build=$(BUILD_DIR)/icu/source/host )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/icu/source
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/icu/source
	@rm -rf $(BUILD_DIR)/icu
