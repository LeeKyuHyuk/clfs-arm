include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/genext2fs-1.4.1.tar.gz
SOURCE_URL := https://downloads.sourceforge.net/project/genext2fs/genext2fs/1.4.1/genext2fs-1.4.1.tar.gz
MD5 := b7b6361bcce2cedff1ae437fadafe53b

toolchain:
	@$(STEP) "genext2fs 1.4.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/genext2fs-1.4.1 && \
	PKG_CONFIG="$(TOOLS_DIR)/usr/bin/pkg-config" \
	PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/usr/lib/pkgconfig:$(TOOLS_DIR)/usr/share/pkgconfig" \
	PKG_CONFIG_SYSROOT_DIR="/" \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
	CPPFLAGS="-I$(TOOLS_DIR)/usr/include" \
	CFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
	LDFLAGS="-L$(TOOLS_DIR)/lib -L$(TOOLS_DIR)/usr/lib -Wl,-rpath,$(TOOLS_DIR)/usr/lib" \
	./configure \
	--prefix=$(TOOLS_DIR)/usr \
	--sysconfdir=$(TOOLS_DIR)/etc \
	--localstatedir=$(TOOLS_DIR)/var \
	--enable-shared \
	--disable-static )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/genext2fs-1.4.1
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/genext2fs-1.4.1
	@rm -rf $(BUILD_DIR)/genext2fs-1.4.1
