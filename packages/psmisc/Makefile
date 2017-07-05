include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/psmisc-22.21.tar.gz
SOURCE_URL := http://downloads.sourceforge.net/project/psmisc/psmisc/psmisc-22.21.tar.gz
MD5 := 935c0fd6eb208288262b385fa656f1bf

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "psmisc 22.21"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/psmisc-22.21 && \
	ac_cv_func_malloc_0_nonnull=yes \
	ac_cv_func_realloc_0_nonnull=yes \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/psmisc-22.21
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/psmisc-22.21
	@mv -v $(ROOTFS_DIR)/usr/bin/fuser $(ROOTFS_DIR)/bin
	@mv -v $(ROOTFS_DIR)/usr/bin/killall $(ROOTFS_DIR)/bin
	@rm -rf $(BUILD_DIR)/psmisc-22.21
