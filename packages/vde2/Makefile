include $(SUPPORT_DIR)/functions.mk

NAME := vde2
SOURCE := $(SOURCES_DIR)/vde2-2.3.2.tar.bz2
SOURCE_URL := https://downloads.sourceforge.net/project/vde/vde2/2.3.2/vde2-2.3.2.tar.bz2
MD5 := 46fbc5f97f03dc517aa3b2c9d9ea6628

toolchain:
	@$(STEP) "vde2 2.3.2"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/vde2-2.3.2 && \
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
	--disable-static \
	--disable-cryptcab \
	--disable-experimental \
	--disable-kernel-switch \
	--disable-pcap \
	--disable-profile \
	--disable-python \
	--enable-tuntap )
	@make -j1 -C $(BUILD_DIR)/vde2-2.3.2
	@make -j1 install -C $(BUILD_DIR)/vde2-2.3.2
	@rm -rf $(BUILD_DIR)/vde2-2.3.2
	@echo $(NAME) >> $(TOOLCHAIN_DEPENDENCIES)
