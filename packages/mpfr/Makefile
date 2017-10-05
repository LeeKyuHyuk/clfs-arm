include $(SUPPORT_DIR)/functions.mk

NAME := mpfr
SOURCE := $(SOURCES_DIR)/mpfr-3.1.5.tar.xz
SOURCE_URL := http://ftpmirror.gnu.org/gnu/mpfr/mpfr-3.1.5.tar.xz
MD5 := c4ac246cf9795a4491e7766002cd528f

toolchain:
	@$(STEP) "mpfr 3.1.5"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/mpfr/Fix-obsolete-ARC-asm-constraints.patch -d $(BUILD_DIR)/mpfr-3.1.5
	@( cd $(BUILD_DIR)/mpfr-3.1.5 && \
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
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/mpfr-3.1.5
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/mpfr-3.1.5
	@rm -rf $(BUILD_DIR)/mpfr-3.1.5
	@echo $(NAME) >> $(TOOLCHAIN_DEPENDENCIES)
