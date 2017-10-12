include $(SUPPORT_DIR)/functions.mk

NAME := nspr
SOURCE := $(SOURCES_DIR)/nspr-4.16.tar.gz
SOURCE_URL := https://archive.mozilla.org/pub/nspr/releases/v4.16/src/nspr-4.16.tar.gz
MD5 := 42fd8963a4b394f62d43ba604f03fab7

ifeq ($(shell uname -m),x86_64)
HOST_64BIT_OPTION = --enable-64bit
endif

ifeq ($(CONFIG_LINUX_ARCH),arm64)
TARGET_64BIT_OPTION = --enable-64bit
endif

toolchain:
	@$(STEP) "nspr 4.16"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/nspr-4.16/nspr && \
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
	--with-mozilla \
	--with-pthreads \
	$(HOST_64BIT_OPTION) )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/nspr-4.16/nspr
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/nspr-4.16/nspr
	@rm -rf $(BUILD_DIR)/nspr-4.16
	@echo $(NAME) >> $(TOOLCHAIN_DEPENDENCIES)

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "nspr 4.16"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/nspr-4.16/nspr && \
	PKG_CONFIG="$(TOOLS_DIR)/bin/pkg-config" \
	ac_cv_lbl_unaligned_fail=yes \
	ac_cv_func_mmap_fixed_mapped=yes \
	ac_cv_func_memcmp_working=yes \
	ac_cv_have_decl_malloc=yes \
	gl_cv_func_malloc_0_nonnull=yes \
	ac_cv_func_malloc_0_nonnull=yes \
	ac_cv_func_calloc_0_nonnull=yes \
	ac_cv_func_realloc_0_nonnull=yes \
	lt_cv_sys_lib_search_path_spec="" \
	ac_cv_c_bigendian=no \
	CONFIG_SITE=/dev/null \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_HOST) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--exec-prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--program-prefix="" \
	--disable-static \
	--enable-shared \
	--with-mozilla \
	--with-pthreads \
	$(TARGET_64BIT_OPTION) )
	@make -j$(CONFIG_PARALLEL_JOBS) LIBRARY= -C $(BUILD_DIR)/nspr-4.16/nspr
	@make -j$(CONFIG_PARALLEL_JOBS) LIBRARY= DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/nspr-4.16/nspr
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) LIBRARY= DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/nspr-4.16/nspr
	@rm -rf $(BUILD_DIR)/nspr-4.16
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
