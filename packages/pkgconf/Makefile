include $(SUPPORT_DIR)/functions.mk

NAME := pkgconf
SOURCE := $(SOURCES_DIR)/pkgconf-0.9.12.tar.bz2
SOURCE_URL := https://github.com/pkgconf/pkgconf/releases/download/pkgconf-0.9.12/pkgconf-0.9.12.tar.bz2
MD5 := a7b523fc9af9357d7199560d2a49ddbf

toolchain:
	@$(STEP) "pkgconf 0.9.12"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/pkgconf/Fix-all-variables-sysroot-prefix-problem.patch -d $(BUILD_DIR)/pkgconf-0.9.12
	@( cd $(BUILD_DIR)/pkgconf-0.9.12 && \
	PKG_CONFIG="$(TOOLS_DIR)/bin/pkg-config" \
	PKG_CONFIG_SYSROOT_DIR="/" \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
	PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/lib/pkgconfig:$(TOOLS_DIR)/share/pkgconfig" \
	CPPFLAGS="-I$(TOOLS_DIR)/include" \
	CFLAGS="-O2 -I$(TOOLS_DIR)/include" \
	CXXFLAGS="-O2 -I$(TOOLS_DIR)/include" \
	LDFLAGS="-L$(TOOLS_DIR)/lib -Wl,-rpath,$(TOOLS_DIR)/lib" \
	CONFIG_SITE=/dev/null \
	./configure \
	--prefix=$(TOOLS_DIR) \
	--sysconfdir=$(TOOLS_DIR)/etc \
	--localstatedir=$(TOOLS_DIR)/var \
	--enable-shared \
	--disable-static )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/pkgconf-0.9.12
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/pkgconf-0.9.12
	@install -v -m755 $(PACKAGES_DIR)/pkgconf/pkg-config $(TOOLS_DIR)/bin/pkg-config
	@sed -i -e "s,@PKG_CONFIG_LIBDIR@,$(SYSROOT_DIR)/usr/lib/pkgconfig:$(SYSROOT_DIR)/usr/share/pkgconfig," -e "s,@STAGING_DIR@,$(SYSROOT_DIR)," $(TOOLS_DIR)/bin/pkg-config
	@sed -i -e "s,@STATIC@,," $(TOOLS_DIR)/bin/pkg-config
	@rm -rf $(BUILD_DIR)/pkgconf-0.9.12
	@echo $(NAME) >> $(TOOLCHAIN_DEPENDENCIES)
