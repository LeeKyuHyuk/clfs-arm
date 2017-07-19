include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/gdk-pixbuf-2.36.6.tar.xz
SOURCE_URL := ftp://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/2.36/gdk-pixbuf-2.36.6.tar.xz
MD5 := 5dd53760750670d27c194ff6ace7eb51

toolchain:
	@$(STEP) "gdk-pixbuf 2.36.6"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/gdk-pixbuf-2.36.6 && \
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
	--disable-static \
	--without-libjpeg \
	--without-libtiff )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/gdk-pixbuf-2.36.6
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/gdk-pixbuf-2.36.6
	@rm -rf $(BUILD_DIR)/gdk-pixbuf-2.36.6

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "gdk-pixbuf 2.36.6"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@cp -f $(TOOLS_DIR)/usr/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache $(BUILD_DIR)/gdk-pixbuf-2.36.6/gdk-pixbuf
	@sed -i -e 's/ tests//' $(BUILD_DIR)/gdk-pixbuf-2.36.6/Makefile.in
	@( cd $(BUILD_DIR)/gdk-pixbuf-2.36.6 && \
	ac_cv_path_GLIB_GENMARSHAL=$(TOOLS_DIR)/usr/bin/glib-genmarshal \
	gio_can_sniff=no \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--disable-glibtest \
	--without-libtiff )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/gdk-pixbuf-2.36.6
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/gdk-pixbuf-2.36.6
	@rm -rf $(BUILD_DIR)/gdk-pixbuf-2.36.6

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "gdk-pixbuf 2.36.6"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@cp -f $(TOOLS_DIR)/usr/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache $(BUILD_DIR)/gdk-pixbuf-2.36.6/gdk-pixbuf
	@sed -i -e 's/ tests//' $(BUILD_DIR)/gdk-pixbuf-2.36.6/Makefile.in
	@( cd $(BUILD_DIR)/gdk-pixbuf-2.36.6 && \
	ac_cv_path_GLIB_GENMARSHAL=$(TOOLS_DIR)/usr/bin/glib-genmarshal \
	gio_can_sniff=no \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--disable-glibtest \
	--without-libtiff )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/gdk-pixbuf-2.36.6
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/gdk-pixbuf-2.36.6
	@rm -rf $(BUILD_DIR)/gdk-pixbuf-2.36.6
