include $(SUPPORT_DIR)/functions.mk

NAME := ifupdown
SOURCE := $(PACKAGES_DIR)/ifupdown/ifupdown_0.8.16.tar.xz
SOURCE_URL := http://snapshot.debian.org/archive/debian/20160922T165503Z/pool/main/i/ifupdown/ifupdown_0.8.16.tar.xz
MD5 := 605c9081ab99b4a745f908f183e2ae9c

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "ifupdown 0.8.16"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/ifupdown/dont-use-dpkg-architecture.patch -d $(BUILD_DIR)/ifupdown
	@make -j$(CONFIG_PARALLEL_JOBS) AR="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar" AS="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as" LD="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld" CC="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc" GCC="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc" CPP="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-cpp" CXX="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++" RANLIB="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib" READELF="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf" STRIP="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip" PKG_CONFIG="$(TOOLS_DIR)/bin/pkg-config" CXX=false CFLAGS="-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -Os -std=gnu99 -D'IFUPDOWN_VERSION=\"0.8.16\"'" -C $(BUILD_DIR)/ifupdown
	@rm -f $(ROOTFS_DIR)/sbin/ifdown
	@rm -f $(ROOTFS_DIR)/sbin/ifquery
	@make -j$(CONFIG_PARALLEL_JOBS) BASEDIR=$(ROOTFS_DIR) -C $(BUILD_DIR)/ifupdown install
	@rm -rf $(BUILD_DIR)/ifupdown
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
