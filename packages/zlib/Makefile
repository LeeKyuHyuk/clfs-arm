include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/zlib-1.2.11.tar.xz
SOURCE_URL := http://zlib.net/zlib-1.2.11.tar.xz
MD5 := 85adef240c5f370b308da8c938951a68

toolchain:
	@$(STEP) "zlib 1.2.11"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/zlib-1.2.11 && \
	PKG_CONFIG="$(TOOLS_DIR)/usr/bin/pkg-config" \
	PKG_CONFIG_SYSROOT_DIR="/" \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
	PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/usr/lib/pkgconfig:$(TOOLS_DIR)/usr/share/pkgconfig" \
	CPPFLAGS="-I$(TOOLS_DIR)/usr/include" \
	CFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
	CXXFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
	LDFLAGS="-L$(TOOLS_DIR)/usr/lib -Wl,-rpath,$(TOOLS_DIR)/usr/lib" \
	./configure \
	--prefix=$(TOOLS_DIR)/usr \
	--enable-shared )
	@make -j1 -C $(BUILD_DIR)/zlib-1.2.11
	@make -j1 LDCONFIG=true install -C $(BUILD_DIR)/zlib-1.2.11
	@rm -rf $(BUILD_DIR)/zlib-1.2.11

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "zlib 1.2.11"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/zlib-1.2.11 && \
	PKG_CONFIG="$(TOOLS_DIR)/usr/bin/pkg-config" \
	CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc \
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
	./configure \
	--shared \
	--prefix=/usr )
	@make -j1 -C $(BUILD_DIR)/zlib-1.2.11
	@make -j1 LDCONFIG=true DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/zlib-1.2.11
	@$(call dependency_libs_patch)
	@make -j1 LDCONFIG=true DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/zlib-1.2.11
	@rm -rf $(BUILD_DIR)/zlib-1.2.11
