include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/icu4c-59_1-src.tgz
SOURCE_URL := http://download.icu-project.org/files/icu4c/59.1/icu4c-59_1-src.tgz
MD5 := 54923fa9fab5b2b83f235fb72523de37

toolchain:
	@$(STEP) "icu 59.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/icu/0001-dont-build-static-dynamic-twice.patch -d $(BUILD_DIR)/icu
	@patch -Np1 -i $(PACKAGES_DIR)/icu/0002-workaround-toolchain-bugs.patch -d $(BUILD_DIR)/icu
	@patch -Np1 -i $(PACKAGES_DIR)/icu/0003-detect-compiler-symbol-prefix.patch -d $(BUILD_DIR)/icu
	@patch -Np1 -i $(PACKAGES_DIR)/icu/0004-link-icudata-as-data-only.patch -d $(BUILD_DIR)/icu
	@patch -Np1 -i $(PACKAGES_DIR)/icu/0005-fix-static-linking-with-icu-uc.patch -d $(BUILD_DIR)/icu
	@( cd $(BUILD_DIR)/icu/source && \
	PKG_CONFIG="$(TOOLS_DIR)/usr/bin/pkg-config" \
	PKG_CONFIG_SYSROOT_DIR="/" \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
	PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/usr/lib/pkgconfig:$(TOOLS_DIR)/usr/share/pkgconfig" \
	CPPFLAGS="-I$(TOOLS_DIR)/usr/include" \
	CFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
	CXXFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
	LDFLAGS="-L$(TOOLS_DIR)/usr/lib -Wl,-rpath,$(TOOLS_DIR)/usr/lib" \
	CONFIG_SITE=/dev/null \
	./configure \
	--prefix=$(TOOLS_DIR)/usr \
	--sysconfdir=$(TOOLS_DIR)/etc \
	--localstatedir=$(TOOLS_DIR)/var \
	--enable-shared \
	--disable-static \
	--disable-samples \
	--disable-tests \
	--disable-extras \
	--disable-icuio \
	--disable-layout \
	--disable-renaming )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/icu/source
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/icu/source
	@mv -v $(BUILD_DIR)/icu $(BUILD_DIR)/host-icu

system:
	@make toolchain -C $(PACKAGES_DIR)/icu
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "icu 59.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/icu/0001-dont-build-static-dynamic-twice.patch -d $(BUILD_DIR)/icu
	@patch -Np1 -i $(PACKAGES_DIR)/icu/0002-workaround-toolchain-bugs.patch -d $(BUILD_DIR)/icu
	@patch -Np1 -i $(PACKAGES_DIR)/icu/0003-detect-compiler-symbol-prefix.patch -d $(BUILD_DIR)/icu
	@patch -Np1 -i $(PACKAGES_DIR)/icu/0004-link-icudata-as-data-only.patch -d $(BUILD_DIR)/icu
	@patch -Np1 -i $(PACKAGES_DIR)/icu/0005-fix-static-linking-with-icu-uc.patch -d $(BUILD_DIR)/icu
	@( cd $(BUILD_DIR)/icu/source && \
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
	LIBS="-latomic" \
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
	--with-cross-build=$(BUILD_DIR)/host-icu/source \
	--disable-samples \
	--disable-tests )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/icu/source
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/icu/source
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/icu/source
	@rm -rf $(BUILD_DIR)/host-icu
	@rm -rf $(BUILD_DIR)/icu
