include $(SUPPORT_DIR)/functions.mk

NAME := pcre
SOURCE := $(SOURCES_DIR)/pcre-8.40.tar.bz2
SOURCE_URL := ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.40.tar.bz2
MD5 := 41a842bf7dcecd6634219336e2167d1d

toolchain:
	@$(STEP) "pcre 8.40"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/pcre-8.40 && \
	PKG_CONFIG="$(TOOLS_DIR)/bin/pkg-config" \
	PKG_CONFIG_SYSROOT_DIR="/" \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
	PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/lib/pkgconfig:$(TOOLS_DIR)/share/pkgconfig" \
	CPPFLAGS="-I$(TOOLS_DIR)/include" \
	CFLAGS="-O2 -I$(TOOLS_DIR)/include" \
	CXXFLAGS="-O2 -I$(TOOLS_DIR)/include" \
	LDFLAGS="-L$(TOOLS_DIR)/lib -Wl,-rpath,$(TOOLS_DIR)/lib" \
	CONFIG_SITE=/dev/null \
	./configure \
	--prefix=$(TOOLS_DIR) \
	--sysconfdir=$(TOOLS_DIR)/etc \
	--localstatedir=$(TOOLS_DIR)/var \
	--enable-shared \
	--disable-static \
	--enable-pcre8 \
	--disable-pcre16 \
	--disable-pcre32 \
	--enable-utf \
	--enable-unicode-properties )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/pcre-8.40
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/pcre-8.40
	@rm -rf $(BUILD_DIR)/pcre-8.40
	@echo $(NAME) >> $(TOOLCHAIN_DEPENDENCIES)

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "pcre 8.40"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/pcre-8.40 && \
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
	--enable-pcre8 \
	--disable-pcre16 \
	--disable-pcre32 \
	--enable-utf \
	--enable-unicode-properties )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/pcre-8.40
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/pcre-8.40
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/pcre-8.40
	@rm -rf $(BUILD_DIR)/pcre-8.40
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
