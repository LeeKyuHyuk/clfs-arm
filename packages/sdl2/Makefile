include $(SUPPORT_DIR)/functions.mk

NAME := sdl2
SOURCE := $(SOURCES_DIR)/SDL2-2.0.5.tar.gz
SOURCE_URL := http://www.libsdl.org/release/SDL2-2.0.5.tar.gz
MD5 := d4055424d556b4a908aa76fad63abd3c

toolchain:
	@$(STEP) "SDL2 2.0.5"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/SDL2-2.0.5 && \
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
	--localstatedir=$(TOOLS_DIR)/var )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/SDL2-2.0.5
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/SDL2-2.0.5
	@rm -rf $(BUILD_DIR)/SDL2-2.0.5
	@echo $(NAME) >> $(TOOLCHAIN_DEPENDENCIES)
