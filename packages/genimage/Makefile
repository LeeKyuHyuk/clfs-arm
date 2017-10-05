include $(SUPPORT_DIR)/functions.mk

NAME := genimage
HOST_DEPENDENCIES := pkgconf libconfuse
SOURCE := $(SOURCES_DIR)/genimage-9.tar.xz
SOURCE_URL := http://public.pengutronix.de/software/genimage/genimage-9.tar.xz
MD5 := 5ad1f651ea9b5678d55c18c693c73e7d

toolchain:
	@$(STEP) "genimage 9"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/genimage-9 && \
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
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/genimage-9
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/genimage-9
	@rm -rf $(BUILD_DIR)/genimage-9
	@echo $(NAME) >> $(TOOLCHAIN_DEPENDENCIES)
