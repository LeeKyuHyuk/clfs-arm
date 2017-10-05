include $(SUPPORT_DIR)/functions.mk

NAME := mpc
SOURCE := $(SOURCES_DIR)/mpc-1.0.3.tar.gz
SOURCE_URL := http://ftpmirror.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz
MD5 := d6a1d5f8ddea3abd2cc3e98f58352d26

toolchain:
	@$(STEP) "mpc 1.0.3"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/mpc-1.0.3 && \
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
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/mpc-1.0.3
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/mpc-1.0.3
	@rm -rf $(BUILD_DIR)/mpc-1.0.3
	@echo $(NAME) >> $(TOOLCHAIN_DEPENDENCIES)
