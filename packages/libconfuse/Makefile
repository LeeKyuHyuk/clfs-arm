include $(SUPPORT_DIR)/functions.mk

NAME := libconfuse
SOURCE := $(SOURCES_DIR)/confuse-3.0.tar.xz
SOURCE_URL := https://github.com/martinh/libconfuse/releases/download/v3.0/confuse-3.0.tar.xz
MD5 := c534b51a2118ed57031dc548032304a3

toolchain:
	@$(STEP) "libconfuse 3.0"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/confuse-3.0 && \
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
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/confuse-3.0
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/confuse-3.0
	@rm -rf $(BUILD_DIR)/confuse-3.0
	@echo $(NAME) >> $(TOOLCHAIN_DEPENDENCIES)
