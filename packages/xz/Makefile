include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/xz-5.2.3.tar.xz
SOURCE_URL := http://tukaani.org/xz/xz-5.2.3.tar.xz
MD5 := 60fb79cab777e3f71ca43d298adacbd5

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "xz 5.2.3"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/xz-5.2.3 && \
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
	--disable-static \
	--enable-shared )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/xz-5.2.3
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/xz-5.2.3
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/xz-5.2.3
	@mv -v $(ROOTFS_DIR)/usr/bin/lzma $(ROOTFS_DIR)/bin
	@mv -v $(ROOTFS_DIR)/usr/bin/unlzma $(ROOTFS_DIR)/bin
	@mv -v $(ROOTFS_DIR)/usr/bin/lzcat $(ROOTFS_DIR)/bin
	@mv -v $(ROOTFS_DIR)/usr/bin/xz $(ROOTFS_DIR)/bin
	@mv -v $(ROOTFS_DIR)/usr/bin/unxz $(ROOTFS_DIR)/bin
	@mv -v $(ROOTFS_DIR)/usr/bin/xzcat $(ROOTFS_DIR)/bin
	@mv -v $(ROOTFS_DIR)/usr/lib/liblzma.so.* $(ROOTFS_DIR)/lib
	@ln -svf ../../lib/`readlink $(ROOTFS_DIR)/usr/lib/liblzma.so` $(ROOTFS_DIR)/usr/lib/liblzma.so
	@rm -rf $(BUILD_DIR)/xz-5.2.3
