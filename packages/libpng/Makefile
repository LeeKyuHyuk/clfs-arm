include $(SUPPORT_DIR)/functions.mk

NAME := libpng
HOST_DEPENDENCIES := zlib
TARGET_DEPENDENCIES := zlib
SOURCE := $(SOURCES_DIR)/libpng-1.6.31.tar.xz
SOURCE_URL := http://downloads.sourceforge.net/libpng/libpng-1.6.31.tar.xz
MD5 := 1b34eab440263e32cfa39d19413fad54

toolchain:
	@$(STEP) "libpng 1.6.31"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/libpng/Disable-pngfix-and-png-fix-itxt.patch -d $(BUILD_DIR)/libpng-1.6.31
	@patch -Np1 -i $(PACKAGES_DIR)/libpng/Don-t-append-prefix-to-symbol-names-in-version-script.patch -d $(BUILD_DIR)/libpng-1.6.31
	@( cd $(BUILD_DIR)/libpng-1.6.31 && \
	PKG_CONFIG="$(TOOLS_DIR)/bin/pkg-config" \
	PKG_CONFIG_SYSROOT_DIR="/" \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
	PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/lib/pkgconfig:$(TOOLS_DIR)/share/pkgconfig" \
	CPPFLAGS="-I$(TOOLS_DIR)/include" \
	CFLAGS="-O2 -I$(TOOLS_DIR)/include" \
	CXXFLAGS="-O2 -I$(TOOLS_DIR)/include" \
	LDFLAGS="-L$(TOOLS_DIR)/lib -Wl,-rpath,$(TOOLS_DIR)/lib" \
	CONFIG_SITE=/dev/null \
	./configure \
	--prefix=$(TOOLS_DIR) \
	--sysconfdir=$(TOOLS_DIR)/etc \
	--localstatedir=$(TOOLS_DIR)/var \
	--enable-shared \
	--disable-static )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/libpng-1.6.31
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/libpng-1.6.31
	@rm -rf $(BUILD_DIR)/libpng-1.6.31
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
	@$(STEP) "libpng 1.6.31"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/libpng/Disable-pngfix-and-png-fix-itxt.patch -d $(BUILD_DIR)/libpng-1.6.31
	@patch -Np1 -i $(PACKAGES_DIR)/libpng/Don-t-append-prefix-to-symbol-names-in-version-script.patch -d $(BUILD_DIR)/libpng-1.6.31
	@( cd $(BUILD_DIR)/libpng-1.6.31 && \
	PKG_CONFIG="$(TOOLS_DIR)/bin/pkg-config" \
	ac_cv_lbl_unaligned_fail=yes \
	ac_cv_func_mmap_fixed_mapped=yes \
	ac_cv_func_memcmp_working=yes \
	ac_cv_have_decl_malloc=yes \
	gl_cv_func_malloc_0_nonnull=yes \
	ac_cv_func_malloc_0_nonnull=yes \
	ac_cv_func_calloc_0_nonnull=yes \
	ac_cv_func_realloc_0_nonnull=yes \
	lt_cv_sys_lib_search_path_spec="" \
	ac_cv_c_bigendian=no \
	LIBS=-lpthread \
	CONFIG_SITE=/dev/null \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--exec-prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--program-prefix="" \
	--disable-static \
	--enable-shared \
	--enable-arm-neon \
	--disable-intel-sse )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/libpng-1.6.31
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/libpng-1.6.31
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/libpng-1.6.31
	@rm -rf $(BUILD_DIR)/libpng-1.6.31
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
