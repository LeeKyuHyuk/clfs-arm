include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/32d6d7d8a2ef328a2ee1dd40f072e21f4983ebda
SOURCE_URL := https://codeload.github.com/google/snappy/tar.gz/32d6d7d8a2ef328a2ee1dd40f072e21f4983ebda
MD5 := e3c76d092a1405db503b92db2d65c81f

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "snappy 1.1.6"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@mkdir -p $(BUILD_DIR)/snappy-32d6d7d8a2ef328a2ee1dd40f072e21f4983ebda
	@gzip -d -c $(SOURCES_DIR)/32d6d7d8a2ef328a2ee1dd40f072e21f4983ebda | tar --strip-components=1 -C $(BUILD_DIR)/snappy-32d6d7d8a2ef328a2ee1dd40f072e21f4983ebda -xf -
	@( cd $(BUILD_DIR)/snappy-32d6d7d8a2ef328a2ee1dd40f072e21f4983ebda && \
	./autogen.sh \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--disable-static \
	--enable-shared \
	--disable-gtest )
	@( cd $(BUILD_DIR)/snappy-32d6d7d8a2ef328a2ee1dd40f072e21f4983ebda && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--disable-static \
	--enable-shared \
	--disable-gtest )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/snappy-32d6d7d8a2ef328a2ee1dd40f072e21f4983ebda
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/snappy-32d6d7d8a2ef328a2ee1dd40f072e21f4983ebda
	@rm -rf $(BUILD_DIR)/snappy-32d6d7d8a2ef328a2ee1dd40f072e21f4983ebda

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "snappy 1.1.6"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@mkdir -p $(BUILD_DIR)/snappy-32d6d7d8a2ef328a2ee1dd40f072e21f4983ebda
	@gzip -d -c $(SOURCES_DIR)/32d6d7d8a2ef328a2ee1dd40f072e21f4983ebda | tar --strip-components=1 -C $(BUILD_DIR)/snappy-32d6d7d8a2ef328a2ee1dd40f072e21f4983ebda -xf -
	@( cd $(BUILD_DIR)/snappy-32d6d7d8a2ef328a2ee1dd40f072e21f4983ebda && \
	./autogen.sh \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--disable-static \
	--enable-shared \
	--disable-gtest )
	@( cd $(BUILD_DIR)/snappy-32d6d7d8a2ef328a2ee1dd40f072e21f4983ebda && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--disable-static \
	--enable-shared \
	--disable-gtest )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/snappy-32d6d7d8a2ef328a2ee1dd40f072e21f4983ebda
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/snappy-32d6d7d8a2ef328a2ee1dd40f072e21f4983ebda
	@rm -rf $(BUILD_DIR)/snappy-32d6d7d8a2ef328a2ee1dd40f072e21f4983ebda
