include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/libcap-2.25.tar.xz
SOURCE_URL := https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.25.tar.xz
MD5 := 6666b839e5d46c2ad33fc8aa2ceb5f77

toolchain:
	@$(STEP) "libcap 2.25"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@PKG_CONFIG="$(TOOLS_DIR)/usr/bin/pkg-config" PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/usr/lib/pkgconfig:$(TOOLS_DIR)/usr/share/pkgconfig" PKG_CONFIG_SYSROOT_DIR="/" PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 make -j$(CONFIG_PARALLEL_JOBS) RAISE_SETFCAP=no -C $(BUILD_DIR)/libcap-2.25
	@PKG_CONFIG="$(TOOLS_DIR)/usr/bin/pkg-config" PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/usr/lib/pkgconfig:$(TOOLS_DIR)/usr/share/pkgconfig" PKG_CONFIG_SYSROOT_DIR="/" PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(TOOLS_DIR) RAISE_SETFCAP=no prefix=/usr lib=lib install -C $(BUILD_DIR)/libcap-2.25
	@rm -rf $(BUILD_DIR)/libcap-2.25

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "libcap 2.25"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/libcap/libcap-2.25-build-system-fixes-for-cross-compilation.patch -d $(BUILD_DIR)/libcap-2.25
	CC="$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc" AR="$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar" LD="$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld" RANLIB="$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib" BUILD_CC="gcc" BUILD_CFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/libcap-2.25/libcap
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) prefix=/usr lib=lib install -C $(BUILD_DIR)/libcap-2.25/libcap
	@rm -rf $(BUILD_DIR)/libcap-2.25

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "libcap 2.25"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/libcap/libcap-2.25-build-system-fixes-for-cross-compilation.patch -d $(BUILD_DIR)/libcap-2.25
	CC="$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc" AR="$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar" LD="$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld" RANLIB="$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib" BUILD_CC="gcc" BUILD_CFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/libcap-2.25/libcap
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) prefix=/usr lib=lib install -C $(BUILD_DIR)/libcap-2.25/libcap
	@rm -rf $(BUILD_DIR)/libcap-2.25
