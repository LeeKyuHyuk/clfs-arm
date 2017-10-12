include $(SUPPORT_DIR)/functions.mk

NAME := autoconf-2.13
HOST_DEPENDENCIES := m4 libtool
SOURCE := $(SOURCES_DIR)/autoconf-2.13.tar.gz
SOURCE_URL := http://ftpmirror.gnu.org/gnu/autoconf/autoconf-2.13.tar.gz
MD5 := 9de56d4a161a723228220b0f425dc711

toolchain:
	@$(STEP) "autoconf 2.13"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/autoconf-2.13/autoconf-2.13-consolidated_fixes-1.patch -d $(BUILD_DIR)/autoconf-2.13
	@mv -v $(BUILD_DIR)/autoconf-2.13/autoconf.texi $(BUILD_DIR)/autoconf-2.13/autoconf213.texi
	@rm -v $(BUILD_DIR)/autoconf-2.13/autoconf.info
	@( cd $(BUILD_DIR)/autoconf-2.13 && \
	PKG_CONFIG="$(TOOLS_DIR)/bin/pkg-config" \
	PKG_CONFIG_SYSROOT_DIR="/" \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
	PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/lib/pkgconfig:$(TOOLS_DIR)/share/pkgconfig" \
	CPPFLAGS="-I$(TOOLS_DIR)/include" \
	CFLAGS="-O2 -I$(TOOLS_DIR)/include" \
	CXXFLAGS="-O2 -I$(TOOLS_DIR)/include" \
	LDFLAGS="-L$(TOOLS_DIR)/lib -Wl,-rpath,$(TOOLS_DIR)/lib" \
	EMACS="no" \
	ac_cv_path_M4=$(TOOLS_DIR)/bin/m4 \
	ac_cv_prog_gnu_m4_gnu=no \
	CONFIG_SITE=/dev/null \
	./configure \
	--prefix=$(TOOLS_DIR) \
	--sysconfdir=$(TOOLS_DIR)/etc \
	--localstatedir=$(TOOLS_DIR)/var \
	--enable-shared \
	--disable-static \
	--program-suffix=2.13 )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/autoconf-2.13
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/autoconf-2.13
	@rm -rf $(BUILD_DIR)/autoconf-2.13
	@echo $(NAME) >> $(TOOLCHAIN_DEPENDENCIES)
