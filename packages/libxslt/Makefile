include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/libxslt-1.1.29.tar.gz
SOURCE_URL := http://xmlsoft.org/sources/libxslt-1.1.29.tar.gz
MD5 := a129d3c44c022de3b9dcf6d6f288d72e

toolchain:
	@$(STEP) "libxslt 1.1.29"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/libxslt-1.1.29 && \
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
	--without-python \
	--without-crypto )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/libxslt-1.1.29
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/libxslt-1.1.29
	@rm -rf $(BUILD_DIR)/libxslt-1.1.29
