include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/flex-2.6.4.tar.gz
SOURCE_URL := https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz
MD5 := 2882e3179748cc9f9c23ec593d6adc8d

toolchain:
	@$(STEP) "flex 2.6.4"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/flex/flex-disable-documentation.patch -d $(BUILD_DIR)/flex-2.6.4
	@( cd $(BUILD_DIR)/flex-2.6.4 && \
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
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/flex-2.6.4
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/flex-2.6.4
	@rm -rf $(BUILD_DIR)/flex-2.6.4

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "flex 2.6.4"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/flex-2.6.4 && \
	HELP2MAN=true \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--docdir=/usr/share/doc/flex-2.6.4 \
	--disable-bootstrap )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/flex-2.6.4
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/flex-2.6.4
	@ln -sv flex $(ROOTFS_DIR)/usr/bin/lex
	@rm -rf $(BUILD_DIR)/flex-2.6.4
