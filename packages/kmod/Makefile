include $(SUPPORT_DIR)/functions.mk

NAME := kmod
HOST_DEPENDENCIES := pkgconf
TARGET_DEPENDENCIES := zlib xz
SOURCE := $(SOURCES_DIR)/kmod-24.tar.xz
SOURCE_URL := https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-24.tar.xz
MD5 := 08297dfb6f2b3f625f928ca3278528af

toolchain:
	@$(STEP) "kmod 24"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/kmod-24 && \
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
	--disable-manpages )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/kmod-24
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/kmod-24
	@mkdir -p $(TOOLS_DIR)/sbin/
	@ln -svf ../usr/bin/kmod $(TOOLS_DIR)/sbin/depmod
	@rm -rf $(BUILD_DIR)/kmod-24
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
	@$(STEP) "kmod 24"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/kmod/fix-O_CLOEXEC.patch -d $(BUILD_DIR)/kmod-24
	@patch -Np1 -i $(PACKAGES_DIR)/kmod/shared-util.c-assert_cc-can-only-be-used-inside-func.patch -d $(BUILD_DIR)/kmod-24
	@( cd $(BUILD_DIR)/kmod-24 && \
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
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--bindir=/bin \
	--sysconfdir=/etc \
	--with-rootlibdir=/lib \
	--disable-static \
	--enable-shared \
	--with-xz \
	--with-zlib )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/kmod-24
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/kmod-24
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/kmod-24
	@for target in depmod insmod lsmod modinfo modprobe rmmod; do \
		ln -sfv ../bin/kmod $(ROOTFS_DIR)/sbin/$${target} ; \
	done
	@ln -sfv kmod $(ROOTFS_DIR)/bin/lsmod
	@rm -rf $(BUILD_DIR)/kmod-24
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
