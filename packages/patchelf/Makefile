include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/patchelf-0.9.tar.bz2
SOURCE_URL := https://nixos.org/releases/patchelf/patchelf-0.9/patchelf-0.9.tar.bz2
MD5 := d02687629c7e1698a486a93a0d607947

toolchain:
	@$(STEP) "patchelf 0.9"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/patchelf-0.9 && \
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
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/patchelf-0.9
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/patchelf-0.9
	@rm -rf $(BUILD_DIR)/patchelf-0.9
