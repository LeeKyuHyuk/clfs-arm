include $(SUPPORT_DIR)/functions.mk

NAME := fakeroot
SOURCE := $(PACKAGES_DIR)/fakeroot/fakeroot_1.20.2.orig.tar.bz2
SOURCE_URL := http://ftp.debian.org/debian/pool/main/f/fakeroot/fakeroot_1.20.2.orig.tar.bz2
MD5 := a4b4564a75024aa96c86e4d1017ac786

toolchain:
	@$(STEP) "fakeroot 1.20.2"
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/fakeroot-1.20.2 && \
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
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/fakeroot-1.20.2
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/fakeroot-1.20.2
	@rm -rf $(BUILD_DIR)/fakeroot-1.20.2
	@echo $(NAME) >> $(TOOLCHAIN_DEPENDENCIES)
