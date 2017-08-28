include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/gettext-0.19.8.1.tar.xz
SOURCE_URL := http://ftpmirror.gnu.org/gnu/gettext/gettext-0.19.8.1.tar.xz
MD5 := df3f5690eaa30fd228537b00cb7b7590

toolchain:
	@$(STEP) "gettext 0.19.8.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -i -e '/^SUBDIRS/s/ doc //;/^SUBDIRS/s/examples$$//' $(BUILD_DIR)/gettext-0.19.8.1/gettext-tools/Makefile.in
	@sed -i -e '/^SUBDIRS/s/ doc //;/^SUBDIRS/s/tests$$//' $(BUILD_DIR)/gettext-0.19.8.1/gettext-tools/Makefile.in
	@( cd $(BUILD_DIR)/gettext-0.19.8.1/gettext-tools && autoconf )
	@( cd $(BUILD_DIR)/gettext-0.19.8.1/gettext-tools && \
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
	--disable-libasprintf \
	--disable-acl \
	--disable-openmp \
	--disable-rpath \
	--disable-java \
	--disable-native-java \
	--disable-csharp \
	--disable-relocatable \
	--without-emacs )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/gettext-0.19.8.1/gettext-tools
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/gettext-0.19.8.1/gettext-tools
	@sed -i -e '/read dummy/d' $(TOOLS_DIR)/usr/bin/gettextize
	@rm -rf $(BUILD_DIR)/gettext-0.19.8.1

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "gettext 0.19.8.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -i -e '/^SUBDIRS/s/ doc //;/^SUBDIRS/s/examples$$//' $(BUILD_DIR)/gettext-0.19.8.1/gettext-tools/Makefile.in
	@sed -i -e '/^SUBDIRS/s/ doc //;/^SUBDIRS/s/tests$$//' $(BUILD_DIR)/gettext-0.19.8.1/gettext-tools/Makefile.in
	@sed -i '/^TESTS =/d' $(BUILD_DIR)/gettext-0.19.8.1/gettext-runtime/tests/Makefile.in
	@sed -i 's/test-lock..EXEEXT.//' $(BUILD_DIR)/gettext-0.19.8.1/gettext-tools/gnulib-tests/Makefile.in
	@( cd $(BUILD_DIR)/gettext-0.19.8.1 && \
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
	--disable-static \
	--enable-shared )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/gettext-0.19.8.1
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/gettext-0.19.8.1
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/gettext-0.19.8.1
	@chmod -v 0755 $(ROOTFS_DIR)/usr/lib/preloadable_libintl.so
	@rm -rf $(BUILD_DIR)/gettext-0.19.8.1
