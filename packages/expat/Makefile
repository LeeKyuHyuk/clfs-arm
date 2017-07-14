include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/expat-2.2.2.tar.bz2
SOURCE_URL := https://downloads.sourceforge.net/project/expat/expat/2.2.2/expat-2.2.2.tar.bz2
MD5 := 1ede9a41223c78528b8c5d23e69a2667

toolchain:
	@$(STEP) "expat 2.2.2"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/expat-2.2.2 && \
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
	--disable-static )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/expat-2.2.2
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/expat-2.2.2
	@rm -rf $(BUILD_DIR)/expat-2.2.2
