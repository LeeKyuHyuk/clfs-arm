include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/acl-2.2.52.src.tar.gz
SOURCE_URL := http://download.savannah.gnu.org/releases/acl/acl-2.2.52.src.tar.gz
MD5 := a61415312426e9c2212bd7dc7929abda

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "acl 2.2.52"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/acl-2.2.52 && \
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
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/acl-2.2.52
	@make -j$(CONFIG_PARALLEL_JOBS) prefix=$(SYSROOT_DIR)/usr exec_prefix=$(SYSROOT_DIR)/usr PKG_DEVLIB_DIR=$(SYSROOT_DIR)/usr/lib install-dev install-lib -C $(BUILD_DIR)/acl-2.2.52
	@sed -i -e "s,libdir=.*,libdir='$(SYSROOT_DIR)'," $(SYSROOT_DIR)/usr/lib/libacl.la
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) prefix=$(ROOTFS_DIR)/usr exec_prefix=$(ROOTFS_DIR)/usr install install-lib -C $(BUILD_DIR)/acl-2.2.52
	@rm -rf $(BUILD_DIR)/acl-2.2.52
