include $(SUPPORT_DIR)/functions.mk

NAME := curl
HOST_DEPENDENCIES := pkgconf openssl
SOURCE := $(SOURCES_DIR)/curl-7.54.1.tar.bz2
SOURCE_URL := https://curl.haxx.se/download/curl-7.54.1.tar.bz2
MD5 := 6b6eb722f512e7a24855ff084f54fe55

toolchain:
	@$(STEP) "curl 7.54.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/curl-7.54.1 && \
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
	--enable-threaded-resolver )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/curl-7.54.1
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/curl-7.54.1
	@rm -rf $(BUILD_DIR)/curl-7.54.1
	@echo $(NAME) >> $(TOOLCHAIN_DEPENDENCIES)
