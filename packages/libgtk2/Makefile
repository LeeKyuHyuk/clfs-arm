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
	CFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
	CPPFLAGS="-I$(TOOLS_DIR)/usr/include" \
	CXXFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
	LDFLAGS="-L$(TOOLS_DIR)/lib -L$(TOOLS_DIR)/usr/lib -Wl,-rpath,$(TOOLS_DIR)/usr/lib" \
	PKG_CONFIG="$(TOOLS_DIR)/usr/bin/pkg-config" \
	PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/usr/lib/pkgconfig:$(TOOLS_DIR)/usr/share/pkgconfig" \
	PKG_CONFIG_SYSROOT_DIR="/" \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
	./configure \
	--prefix=$(TOOLS_DIR)/usr \
	--disable-glibtest \
	--without-libtiff \
	--with-gdktarget=none )
	@make -j$(CONFIG_PARALLEL_JOBS) gtk-update-icon-cache -C $(BUILD_DIR)/gtk+-2.24.30/gtk
	@cp -v $(BUILD_DIR)/gtk+-2.24.30/gtk/gtk-update-icon-cache $(TOOLS_DIR)/usr/bin
	@rm -rf $(BUILD_DIR)/gtk+-2.24.30

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
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
	ac_cv_path_GTK_UPDATE_ICON_CACHE=$(TOOLS_DIR)/usr/bin/gtk-update-icon-cache \
	ac_cv_path_GDK_PIXBUF_CSOURCE=$(TOOLS_DIR)/usr/bin/gdk-pixbuf-csource \
	DB2HTML=false \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
 	--prefix=$(SYSROOT_DIR)/usr \
	--sysconfdir=$(SYSROOT_DIR)/etc )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/gtk+-2.24.30
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/gtk+-2.24.30
	@rm -rf $(BUILD_DIR)/gtk+-2.24.30

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
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
	ac_cv_path_GTK_UPDATE_ICON_CACHE=$(TOOLS_DIR)/usr/bin/gtk-update-icon-cache \
	ac_cv_path_GDK_PIXBUF_CSOURCE=$(TOOLS_DIR)/usr/bin/gdk-pixbuf-csource \
	DB2HTML=false \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
 	--prefix=/usr \
	--sysconfdir=/etc )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/gtk+-2.24.30
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/gtk+-2.24.30
	@echo "include \"/usr/share/themes/Glider/gtk-2.0/gtkrc\"" > $(ROOTFS_DIR)/etc/gtk-2.0/gtkrc
	@echo "gtk-icon-theme-name = \"hicolor\"" >> $(ROOTFS_DIR)/etc/gtk-2.0/gtkrc
	@rm -rf $(BUILD_DIR)/gtk+-2.24.30
