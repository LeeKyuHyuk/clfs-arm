include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/binutils-2.29.tar.xz
SOURCE_URL := http://ftpmirror.gnu.org/gnu/binutils/binutils-2.29.tar.xz
MD5 := 87978750715952fbb9f870940e9dcbeb

toolchain:
	@$(STEP) "binutils 2.29"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@mkdir -pv $(BUILD_DIR)/binutils-2.29/binutils-build
	@( cd $(BUILD_DIR)/binutils-2.29/binutils-build && \
	AR="ar" \
	AS="as" \
	$(BUILD_DIR)/binutils-2.29/configure \
	--prefix=$(TOOLS_DIR) \
	--sysconfdir=$(TOOLS_DIR)/etc \
	--localstatedir=$(TOOLS_DIR)/var \
	--enable-shared \
	--disable-static \
	--disable-multilib \
	--disable-werror \
	--target=$(CONFIG_TARGET) \
	--disable-shared \
	--enable-static \
	--with-sysroot=$(SYSROOT_DIR) \
	--enable-poison-system-directories \
	--disable-sim \
	--disable-gdb )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/binutils-2.29/binutils-build
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/binutils-2.29/binutils-build
	@rm -rf $(BUILD_DIR)/binutils-2.29

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "binutils 2.29"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@mkdir -pv $(BUILD_DIR)/binutils-2.29/binutils-build
	@( cd $(BUILD_DIR)/binutils-2.29/binutils-build && \
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
	$(BUILD_DIR)/binutils-2.29/configure \
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
	--enable-gold \
	--enable-ld=default \
	--enable-plugins \
	--disable-werror \
	--with-system-zlib )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/binutils-2.29/binutils-build
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/binutils-2.29/binutils-build
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/binutils-2.29/binutils-build
	@rm -rf $(BUILD_DIR)/binutils-2.29
