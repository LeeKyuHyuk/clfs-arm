include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/nspr-4.16.tar.gz
SOURCE_URL := https://ftp.mozilla.org/pub/nspr/releases/v4.16/src/nspr-4.16.tar.gz
MD5 := 42fd8963a4b394f62d43ba604f03fab7

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "nspr 4.16"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/nspr-4.16/nspr && \
	HOST_CFLAGS="-g -O2" \
	HOST_LDFLAGS="-lc" \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_HOST) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--with-mozilla \
	--with-pthreads \
	--disable-64bit )
	@make -j$(CONFIG_PARALLEL_JOBS) LIBRARY= -C $(BUILD_DIR)/nspr-4.16/nspr
	@make -j$(CONFIG_PARALLEL_JOBS) LIBRARY= install -C $(BUILD_DIR)/nspr-4.16/nspr
	@rm -rf $(BUILD_DIR)/nspr-4.16/nspr

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "nspr 4.16"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/nspr-4.16/nspr && \
	HOST_CFLAGS="-g -O2" \
	HOST_LDFLAGS="-lc" \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_HOST) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--with-mozilla \
	--with-pthreads \
	--disable-64bit )
	@make -j$(CONFIG_PARALLEL_JOBS) LIBRARY= -C $(BUILD_DIR)/nspr-4.16/nspr
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) LIBRARY= install -C $(BUILD_DIR)/nspr-4.16/nspr
	@rm -rf $(BUILD_DIR)/nspr-4.16/nspr
