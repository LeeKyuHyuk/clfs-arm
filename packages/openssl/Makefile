include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/openssl-1.0.2k.tar.gz
SOURCE_URL := https://www.openssl.org/source/openssl-1.0.2k.tar.gz
MD5 := f965fc0bf01bf882b31314b61391ae65

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "openssl 1.0.2k"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/openssl-1.0.2k && \
	CROSS_COMPILE=$(CONFIG_TARGET)- \
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
	./Configure \
	linux-armv4 \
	--prefix=/usr \
	--openssldir=/etc/ssl \
	--libdir=/lib \
	shared \
	zlib-dynamic )
	@sed -i -e "s#-march=[-a-z0-9] ##" -e "s#-mcpu=[-a-z0-9] ##g" $(BUILD_DIR)/openssl-1.0.2k/Makefile
	@sed -i -e "s# build_tests##" $(BUILD_DIR)/openssl-1.0.2k/Makefile
	@make -j1 -C $(BUILD_DIR)/openssl-1.0.2k
	@make -j1 INSTALL_PREFIX=$(SYSROOT_DIR) install -C $(BUILD_DIR)/openssl-1.0.2k
	@$(call dependency_libs_patch)
	@make -j1 INSTALL_PREFIX=$(ROOTFS_DIR) install -C $(BUILD_DIR)/openssl-1.0.2k
	@rm -rf $(BUILD_DIR)/openssl-1.0.2k
