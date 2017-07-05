include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/zlib-1.2.11.tar.xz
SOURCE_URL := http://zlib.net/zlib-1.2.11.tar.xz
MD5 := 85adef240c5f370b308da8c938951a68

toolchain:
	@$(STEP) "zlib 1.2.11"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/zlib-1.2.11 && \
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
	--enable-shared )
	@make -j1 -C $(BUILD_DIR)/zlib-1.2.11
	@make -j1 LDCONFIG=true install -C $(BUILD_DIR)/zlib-1.2.11
	@rm -rf $(BUILD_DIR)/zlib-1.2.11

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "zlib 1.2.11"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/zlib-1.2.11 && CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc ./configure --prefix=$(SYSROOT_DIR)/usr )
	@make -j1 -C $(BUILD_DIR)/zlib-1.2.11
	@make -j1 LDCONFIG=true install -C $(BUILD_DIR)/zlib-1.2.11
	@rm -rf $(BUILD_DIR)/zlib-1.2.11

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "zlib 1.2.11"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/zlib-1.2.11 && CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc ./configure --prefix=/usr )
	@make -j1 -C $(BUILD_DIR)/zlib-1.2.11
	@make -j1 LDCONFIG=true DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/zlib-1.2.11
	@rm -rf $(BUILD_DIR)/zlib-1.2.11
