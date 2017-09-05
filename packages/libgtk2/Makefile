include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/gtk+-2.24.30.tar.xz
SOURCE_URL := ftp://ftp.gnome.org/pub/gnome/sources/gtk+/2.24/gtk+-2.24.30.tar.xz
MD5 := 04568ba5c58b75e3c7543e45628ad789

toolchain:
	@$(STEP) "gtk+ 2.24.30"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/libgtk2/libgtk2-reduce-dependencies.patch -d $(BUILD_DIR)/gtk+-2.24.30
	@( cd $(BUILD_DIR)/gtk+-2.24.30 && aclocal )
	@( cd $(BUILD_DIR)/gtk+-2.24.30 && autoheader )
	@( cd $(BUILD_DIR)/gtk+-2.24.30 && autoconf )
	@sed -i -e 's#l \(gtk-.*\).sgml#& -o \1#' $(BUILD_DIR)/gtk+-2.24.30/docs/faq/Makefile.in
	@sed -i -e 's#l \(gtk-.*\).sgml#& -o \1#' $(BUILD_DIR)/gtk+-2.24.30/docs/tutorial/Makefile.in
	@sed -i "/seems to be moved/s/^/#/" $(BUILD_DIR)/gtk+-2.24.30/ltmain.sh
	@sed -i -e 's#modules demos tests#modules#g' $(BUILD_DIR)/gtk+-2.24.30/Makefile.in
	@( cd $(BUILD_DIR)/gtk+-2.24.30 && \
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
	--disable-glibtest \
	--without-libtiff \
	--with-gdktarget=none )
	@make -j$(CONFIG_PARALLEL_JOBS) gtk-update-icon-cache -C $(BUILD_DIR)/gtk+-2.24.30/gtk
	@cp -v $(BUILD_DIR)/gtk+-2.24.30/gtk/gtk-update-icon-cache $(TOOLS_DIR)/bin
	@rm -rf $(BUILD_DIR)/gtk+-2.24.30

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "gtk+ 2.24.30"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/libgtk2/libgtk2-reduce-dependencies.patch -d $(BUILD_DIR)/gtk+-2.24.30
	@( cd $(BUILD_DIR)/gtk+-2.24.30 && aclocal )
	@( cd $(BUILD_DIR)/gtk+-2.24.30 && autoheader )
	@( cd $(BUILD_DIR)/gtk+-2.24.30 && autoconf )
	@sed -i -e 's#l \(gtk-.*\).sgml#& -o \1#' $(BUILD_DIR)/gtk+-2.24.30/docs/faq/Makefile.in
	@sed -i -e 's#l \(gtk-.*\).sgml#& -o \1#' $(BUILD_DIR)/gtk+-2.24.30/docs/tutorial/Makefile.in
	@sed -i "/seems to be moved/s/^/#/" $(BUILD_DIR)/gtk+-2.24.30/ltmain.sh
	@sed -i -e 's#modules demos tests#modules#g' $(BUILD_DIR)/gtk+-2.24.30/Makefile.in
	@( cd $(BUILD_DIR)/gtk+-2.24.30 && \
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
	ac_cv_path_GTK_UPDATE_ICON_CACHE=$(TOOLS_DIR)/bin/gtk-update-icon-cache \
	ac_cv_path_GDK_PIXBUF_CSOURCE=$(TOOLS_DIR)/bin/gdk-pixbuf-csource \
	DB2HTML=false \
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
	--enable-broadway-backend \
	--enable-x11-backend \
	--enable-wayland-backend )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/gtk+-2.24.30
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/gtk+-2.24.30
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/gtk+-2.24.30
	@cp -v $(PACKAGES_DIR)/libgtk2/gtkrc $(ROOTFS_DIR)/etc/gtk-2.0/gtkrc
	@rm -rf $(BUILD_DIR)/gtk+-2.24.30
