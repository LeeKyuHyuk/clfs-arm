include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/attr-2.4.47.src.tar.gz
SOURCE_URL := http://download.savannah.gnu.org/releases/attr/attr-2.4.47.src.tar.gz
MD5 := 84f58dec00b60f2dc8fd1c9709291cc7

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "attr 2.4.47"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/attr/support-static-installation.patch -d $(BUILD_DIR)/attr-2.4.47
	@patch -Np1 -i $(PACKAGES_DIR)/attr/avoid-glibc-specific-decls-defines.patch -d $(BUILD_DIR)/attr-2.4.47
	@patch -Np1 -i $(PACKAGES_DIR)/attr/portability-fixes.patch -d $(BUILD_DIR)/attr-2.4.47
	@( cd $(BUILD_DIR)/attr-2.4.47 && \
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
	--exec-prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--program-prefix="" \
	--disable-static \
	--enable-shared \
	--enable-gettext=no )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/attr-2.4.47
	@make -j$(CONFIG_PARALLEL_JOBS) prefix=$(SYSROOT_DIR)/usr exec_prefix=$(SYSROOT_DIR)/usr PKG_DEVLIB_DIR=$(SYSROOT_DIR)/usr/lib install-dev install-lib -C $(BUILD_DIR)/attr-2.4.47
	@sed -i -e "s,libdir=.*,libdir='$(SYSROOT_DIR)'," $(SYSROOT_DIR)/usr/lib/libattr.la
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) prefix=$(ROOTFS_DIR)/usr exec_prefix=$(ROOTFS_DIR)/usr install install-lib -C $(BUILD_DIR)/attr-2.4.47
	@rm -rf $(BUILD_DIR)/attr-2.4.47
