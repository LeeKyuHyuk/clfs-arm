include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/lzip-1.19.tar.gz
SOURCE_URL := http://download.savannah.gnu.org/releases/lzip/lzip-1.19.tar.gz
MD5 := 4dd8790d7528440d034fc713a8680bd3

toolchain:
	@$(STEP) "lzip 1.19"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/lzip-1.19 && \
	PKG_CONFIG="$(TOOLS_DIR)/usr/bin/pkg-config" \
	PKG_CONFIG_SYSROOT_DIR="/" \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
	PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/usr/lib/pkgconfig:$(TOOLS_DIR)/usr/share/pkgconfig" \
	./configure \
	--prefix=$(TOOLS_DIR)/usr \
	CPPFLAGS="-I$(TOOLS_DIR)/usr/include" \
	CFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
	CXXFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
	LDFLAGS="-L$(TOOLS_DIR)/usr/lib -Wl,-rpath,$(TOOLS_DIR)/usr/lib" )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/lzip-1.19
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/lzip-1.19
	@rm -rf $(BUILD_DIR)/lzip-1.19
