include $(SUPPORT_DIR)/functions.mk

NAME := gdk-pixbuf
HOST_DEPENDENCIES := glib libpng pkgconf
TARGET_DEPENDENCIES := glib libpng libjpeg-turbo xlib
SOURCE := $(SOURCES_DIR)/gdk-pixbuf-2.36.6.tar.xz
SOURCE_URL := ftp://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/2.36/gdk-pixbuf-2.36.6.tar.xz
MD5 := 5dd53760750670d27c194ff6ace7eb51

toolchain:
	@$(STEP) "gdk-pixbuf 2.36.6"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/gdk-pixbuf-2.36.6 && \
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
	--without-libjpeg \
	--without-libtiff )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/gdk-pixbuf-2.36.6
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/gdk-pixbuf-2.36.6
	@rm -rf $(BUILD_DIR)/gdk-pixbuf-2.36.6
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
	@$(STEP) "gdk-pixbuf 2.36.6"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@cp -f $(TOOLS_DIR)/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache $(BUILD_DIR)/gdk-pixbuf-2.36.6/gdk-pixbuf
	@sed -i -e 's/ tests//' $(BUILD_DIR)/gdk-pixbuf-2.36.6/Makefile.in
	@( cd $(BUILD_DIR)/gdk-pixbuf-2.36.6 && \
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
	ac_cv_path_GLIB_GENMARSHAL=$(TOOLS_DIR)/bin/glib-genmarshal \
	gio_can_sniff=no \
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
	--disable-glibtest \
	--without-libtiff \
	--with-x11 )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/gdk-pixbuf-2.36.6
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/gdk-pixbuf-2.36.6
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/gdk-pixbuf-2.36.6
	@cp -v $(TOOLS_DIR)/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache $(ROOTFS_DIR)/usr/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache
	@rm -rf $(BUILD_DIR)/gdk-pixbuf-2.36.6
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
