include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/libxml2-2.9.4.tar.gz
SOURCE_URL := ftp://xmlsoft.org/libxml2/libxml2-2.9.4.tar.gz
MD5 := ae249165c173b1ff386ee8ad676815f5

toolchain:
	@$(STEP) "libxml2 2.9.4"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/libxml2-2.9.4 && \
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
	--sysconfdir=$(TOOLS_DIR)/etc \
	--localstatedir=$(TOOLS_DIR)/var \
	--disable-static \
	--without-zlib \
	--without-lzma \
	--without-python )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/libxml2-2.9.4
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/libxml2-2.9.4
	@rm -rf $(BUILD_DIR)/libxml2-2.9.4
