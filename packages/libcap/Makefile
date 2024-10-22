include $(SUPPORT_DIR)/functions.mk

NAME := libcap
HOST_DEPENDENCIES := gperf
SOURCE := $(SOURCES_DIR)/libcap-2.25.tar.xz
SOURCE_URL := https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.25.tar.xz
MD5 := 6666b839e5d46c2ad33fc8aa2ceb5f77

toolchain:
	@$(STEP) "libcap 2.25"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@PKG_CONFIG="$(TOOLS_DIR)/bin/pkg-config" PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/lib/pkgconfig:$(TOOLS_DIR)/share/pkgconfig" PKG_CONFIG_SYSROOT_DIR="/" PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 make -j$(CONFIG_PARALLEL_JOBS) RAISE_SETFCAP=no -C $(BUILD_DIR)/libcap-2.25
	@PKG_CONFIG="$(TOOLS_DIR)/bin/pkg-config" PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/lib/pkgconfig:$(TOOLS_DIR)/share/pkgconfig" PKG_CONFIG_SYSROOT_DIR="/" PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(TOOLS_DIR) RAISE_SETFCAP=no prefix=/usr lib=lib install -C $(BUILD_DIR)/libcap-2.25
	@rm -rf $(BUILD_DIR)/libcap-2.25
	@echo $(NAME) >> $(TOOLCHAIN_DEPENDENCIES)

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "libcap 2.25"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/libcap/libcap-2.25-build-system-fixes-for-cross-compilation.patch -d $(BUILD_DIR)/libcap-2.25
	CC="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc" AR="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar" LD="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld" RANLIB="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib" BUILD_CC="gcc" BUILD_CFLAGS="-O2 -I$(TOOLS_DIR)/include" make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/libcap-2.25/libcap
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) prefix=/usr lib=lib install -C $(BUILD_DIR)/libcap-2.25/libcap
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) prefix=/usr lib=lib install -C $(BUILD_DIR)/libcap-2.25/libcap
	@chmod -v 755 $(ROOTFS_DIR)/usr/lib/libcap.so
	@mv -v $(ROOTFS_DIR)/usr/lib/libcap.so.* $(ROOTFS_DIR)/lib
	@ln -sfv ../../lib/`readlink $(ROOTFS_DIR)/usr/lib/libcap.so` $(ROOTFS_DIR)/usr/lib/libcap.so
	@rm -rf $(BUILD_DIR)/libcap-2.25
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
