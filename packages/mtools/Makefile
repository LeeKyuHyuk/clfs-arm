include $(SUPPORT_DIR)/functions.mk

NAME := mtools
SOURCE := $(SOURCES_DIR)/mtools-4.0.18.tar.bz2
SOURCE_URL := http://ftpmirror.gnu.org/gnu/mtools/mtools-4.0.18.tar.bz2
MD5 := a23646617546bf6ad56f061d8b283c85

toolchain:
	@$(STEP) "mtools 4.0.18"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/mtools-4.0.18 && \
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
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/mtools-4.0.18
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/mtools-4.0.18
	@rm -rf $(BUILD_DIR)/mtools-4.0.18
	@echo $(NAME) >> $(TOOLCHAIN_DEPENDENCIES)
