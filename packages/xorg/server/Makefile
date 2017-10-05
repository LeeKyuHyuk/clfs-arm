include $(SUPPORT_DIR)/functions.mk

NAME := xserver
TARGET_DEPENDENCIES := openssl pixman xkeyboard-config libepoxy libsha1
SOURCE := $(SOURCES_DIR)/xorg-server-1.19.3.tar.bz2
SOURCE_URL := https://www.x.org/releases/individual/xserver/xorg-server-1.19.3.tar.bz2
MD5 := 015d2fc4b9f2bfe7a626edb63a62c65e

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "xorg-server 1.19.3"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/xorg/server/configure.ac-Fix-check-for-CLOCK_MONOTONIC.patch -d $(BUILD_DIR)/xorg-server-1.19.3
	@( cd $(BUILD_DIR)/xorg-server-1.19.3 && autoconf )
	@( cd $(BUILD_DIR)/xorg-server-1.19.3 && \
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
	CFLAGS="-I$(SYSROOT_DIR)/usr/include/pixman-1 -O2" \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--exec-prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--program-prefix="" \
	--disable-static \
	--enable-shared \
	--with-fontrootdir=/usr/share/fonts/X11/ \
	--disable-docs \
	--disable-devel-docs \
	--disable-xwayland \
	--enable-xorg \
	--enable-libdrm \
	--enable-config-udev \
	--enable-config-udev-kms \
	--enable-config-dbus \
	--disable-libunwind \
	--enable-glamor \
	--enable-suid-wrapper \
	--with-sha1=libsha1 )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/xorg-server-1.19.3
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/xorg-server-1.19.3
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/xorg-server-1.19.3
	@rm -rf $(BUILD_DIR)/xorg-server-1.19.3
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
