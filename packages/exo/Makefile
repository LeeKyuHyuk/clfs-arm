include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/exo-0.10.7.tar.bz2
SOURCE_URL := http://archive.xfce.org/src/xfce/exo/0.10/exo-0.10.7.tar.bz2
MD5 := 92ca200b8787cdd7494164cbc0ed8200

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "exo 0.10.7"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np0 -i $(PACKAGES_DIR)/exo/exo-0.10.7-build-system-fixes-for-cross-compilation.patch -d $(BUILD_DIR)/exo-0.10.7
	@( cd $(BUILD_DIR)/exo-0.10.7 && \
	PKG_CONFIG="$(TOOLS_DIR)/usr/bin/pkg-config" \
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
	--exec-prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--program-prefix="" \
	--disable-static \
	--enable-shared )
	@rm -rf $(BUILD_DIR)/exo-0.10.7/tests
	@mkdir -pv $(BUILD_DIR)/exo-0.10.7/tests
	@echo "all:" > $(BUILD_DIR)/exo-0.10.7/tests/Makefile
	@echo "\techo \"\"" >> $(BUILD_DIR)/exo-0.10.7/tests/Makefile
	@echo "install:" >> $(BUILD_DIR)/exo-0.10.7/tests/Makefile
	@echo "\techo \"\"" >> $(BUILD_DIR)/exo-0.10.7/tests/Makefile
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/exo-0.10.7
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/exo-0.10.7
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/exo-0.10.7
	@rm -rf $(BUILD_DIR)/exo-0.10.7
