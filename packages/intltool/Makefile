include $(SUPPORT_DIR)/functions.mk

NAME := intltool
HOST_DEPENDENCIES := gettext libxml-parser-perl
SOURCE := $(SOURCES_DIR)/intltool-0.51.0.tar.gz
SOURCE_URL := https://launchpad.net/intltool/trunk/0.51.0/+download/intltool-0.51.0.tar.gz
MD5 := 12e517cac2b57a0121cda351570f1e63

toolchain:
	@$(STEP) "intltool 0.51.0"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/intltool/perl-5.26-compatibility.patch -d $(BUILD_DIR)/intltool-0.51.0
	@( cd $(BUILD_DIR)/intltool-0.51.0 && \
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
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/intltool-0.51.0
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/intltool-0.51.0
	@rm -rf $(BUILD_DIR)/intltool-0.51.0
	@echo $(NAME) >> $(TOOLCHAIN_DEPENDENCIES)
