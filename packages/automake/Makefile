include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/automake-1.15.tar.xz
SOURCE_URL := http://ftp.gnu.org/gnu/automake/automake-1.15.tar.xz
MD5 := 9a1ddb0e053474d9d1105cfe39b0c48d

toolchain:
	@$(STEP) "automake 1.15"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/automake/noman.patch -d $(BUILD_DIR)/automake-1.15
	@patch -Np1 -i $(PACKAGES_DIR)/automake/port-to-perl-5.22-and-later.patch -d $(BUILD_DIR)/automake-1.15
	@( cd $(BUILD_DIR)/automake-1.15 && \
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
	--sysconfdir=$(TOOLS_DIR)/usr/etc \
	--localstatedir=$(TOOLS_DIR)/usr/var \
	--enable-shared \
	--disable-static )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/automake-1.15
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/automake-1.15
	@install -Dv -m 0644 $(PACKAGES_DIR)/automake/gtk-doc.m4 $(TOOLS_DIR)/usr/share/aclocal/gtk-doc.m4
	@mkdir -p $(SYSROOT_DIR)/usr/share/aclocal
	@rm -rf $(BUILD_DIR)/automake-1.15

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "automake 1.15"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/automake-1.15 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--docdir=/usr/share/doc/automake-1.15 )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/automake-1.15
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/automake-1.15
	@rm -rf $(BUILD_DIR)/automake-1.15
