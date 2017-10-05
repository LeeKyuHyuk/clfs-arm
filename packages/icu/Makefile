include $(SUPPORT_DIR)/functions.mk

NAME := icu
SOURCE := $(SOURCES_DIR)/icu4c-59_1-src.tgz
SOURCE_URL := http://download.icu-project.org/files/icu4c/59.1/icu4c-59_1-src.tgz
MD5 := 54923fa9fab5b2b83f235fb72523de37

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "icu 59.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/icu/dont-build-static-dynamic-twice.patch -d $(BUILD_DIR)/icu
	@patch -Np1 -i $(PACKAGES_DIR)/icu/workaround-toolchain-bugs.patch -d $(BUILD_DIR)/icu
	@patch -Np1 -i $(PACKAGES_DIR)/icu/detect-compiler-symbol-prefix.patch -d $(BUILD_DIR)/icu
	@patch -Np1 -i $(PACKAGES_DIR)/icu/link-icudata-as-data-only.patch -d $(BUILD_DIR)/icu
	@patch -Np1 -i $(PACKAGES_DIR)/icu/fix-static-linking-with-icu-uc.patch -d $(BUILD_DIR)/icu
	@mkdir -p $(BUILD_DIR)/icu/source/host
	@( cd $(BUILD_DIR)/icu/source/host && $(BUILD_DIR)/icu/source/runConfigureICU	Linux/gcc )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/icu/source/host
	@( cd $(BUILD_DIR)/icu/source && \
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
	--exec-prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--program-prefix="" \
	--disable-static \
	--enable-shared \
	--with-cross-build=$(BUILD_DIR)/icu/source/host \
	--disable-samples \
	--disable-tests )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/icu/source
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/icu/source
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/icu/source
	@rm -rf $(BUILD_DIR)/icu
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
