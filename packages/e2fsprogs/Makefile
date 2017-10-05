include $(SUPPORT_DIR)/functions.mk

NAME := e2fsprogs
HOST_DEPENDENCIES := pkgconf util-linux
SOURCE := $(SOURCES_DIR)/e2fsprogs-1.43.4.tar.gz
SOURCE_URL := http://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v1.43.4/e2fsprogs-1.43.4.tar.gz
MD5 := 0bd1c74f357f6e9ae2ab6fa6229b9aea

toolchain:
	@$(STEP) "e2fsprogs 1.43.4"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/e2fsprogs-1.43.4 && \
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
	--disable-static \
	--disable-defrag \
	--disable-e2initrd-helper \
	--disable-fuse2fs \
	--disable-libblkid \
	--disable-libuuid \
	--enable-symlink-install \
	--disable-testio-debug )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/e2fsprogs-1.43.4
	@make -j$(CONFIG_PARALLEL_JOBS) install install-libs -C $(BUILD_DIR)/e2fsprogs-1.43.4
	@rm -rf $(BUILD_DIR)/e2fsprogs-1.43.4
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
	@$(STEP) "e2fsprogs 1.43.4"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/e2fsprogs-1.43.4 && \
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
	CONFIG_SITE=/dev/null \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--bindir=/bin \
	--with-root-prefix="" \
	--enable-elf-shlibs \
	--disable-libblkid \
	--disable-libuuid \
	--disable-uuidd \
	--disable-fsck )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/e2fsprogs-1.43.4
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/e2fsprogs-1.43.4
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install-libs -C $(BUILD_DIR)/e2fsprogs-1.43.4
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/e2fsprogs-1.43.4
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install-libs -C $(BUILD_DIR)/e2fsprogs-1.43.4
	@chmod -v u+w $(ROOTFS_DIR)/usr/lib/libcom_err.a
	@chmod -v u+w $(ROOTFS_DIR)/usr/lib/libe2p.a
	@chmod -v u+w $(ROOTFS_DIR)/usr/lib/libext2fs.a
	@chmod -v u+w $(ROOTFS_DIR)/usr/lib/libss.a
	@rm -rf $(BUILD_DIR)/e2fsprogs-1.43.4
