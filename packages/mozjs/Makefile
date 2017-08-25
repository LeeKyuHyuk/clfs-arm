include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/mozjs17.0.0.tar.gz
SOURCE_URL := https://archive.mozilla.org/pub/js/mozjs17.0.0.tar.gz
MD5 := 20b6f8f1140ef6e47daa3b16965c9202

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "mozjs 17.0.0"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -i 's/(defined\((@TEMPLATE_FILE)\))/\1/' $(BUILD_DIR)/mozjs17.0.0/js/src/config/milestone.pl
	@( cd $(BUILD_DIR)/mozjs17.0.0/js/src && \
	CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc \
	CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++ \
	AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar \
	AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as \
	LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld \
	RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib \
	READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf \
	STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip \
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
	--enable-readline \
	--enable-threadsafe \
	--with-system-ffi \
	--with-system-nspr )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/mozjs17.0.0/js/src
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/mozjs17.0.0/js/src
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/mozjs17.0.0/js/src
	@rm -rf $(BUILD_DIR)/mozjs17.0.0
