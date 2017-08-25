include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/libwnck-2.30.7.tar.xz
SOURCE_URL := ftp://ftp.gnome.org/pub/gnome/sources/libwnck/2.30/libwnck-2.30.7.tar.xz
MD5 := 3d20f26105a2fd878899d6ecdbe9a082

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "libwnck 2.30.7"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/libwnck-2.30.7 && \
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
	--enable-shared \
	--program-suffix=-1 )
	@make -j$(CONFIG_PARALLEL_JOBS) GETTEXT_PACKAGE=libwnck-1 -C $(BUILD_DIR)/libwnck-2.30.7
	@make -j$(CONFIG_PARALLEL_JOBS) GETTEXT_PACKAGE=libwnck-1 DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/libwnck-2.30.7
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) GETTEXT_PACKAGE=libwnck-1 DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/libwnck-2.30.7
	@rm -rf $(BUILD_DIR)/libwnck-2.30.7
