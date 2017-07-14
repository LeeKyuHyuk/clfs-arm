include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/libarchive-3.3.1.tar.gz
SOURCE_URL := http://www.libarchive.org/downloads/libarchive-3.3.1.tar.gz
MD5 := d2af45480aa5b0db5b5f3919cd0ea65e

toolchain:
	@$(STEP) "libarchive 3.3.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/libarchive-3.3.1 && \
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
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/libarchive-3.3.1
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/libarchive-3.3.1
	@rm -rf $(BUILD_DIR)/libarchive-3.3.1
