include $(SUPPORT_DIR)/functions.mk

NAME := cairo
TARGET_DEPENDENCIES := fontconfig pixman mesa glib
SOURCE := $(SOURCES_DIR)/cairo-1.14.10.tar.xz
SOURCE_URL := http://cairographics.org/releases/cairo-1.14.10.tar.xz
MD5 := 146f5f4d0b4439fc3792fd3452b7b12a

toolchain:
	@$(STEP) "cairo 1.14.10"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@$(call system_dependencies, $(HOST_DEPENDENCIES))
	@( cd $(BUILD_DIR)/cairo-1.14.10 && \
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
	--disable-tee )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/cairo-1.14.10
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/cairo-1.14.10
	@rm -rf $(BUILD_DIR)/cairo-1.14.10
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
	@$(STEP) "cairo 1.14.10"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/cairo-1.14.10 && \
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
	LIBS="-latomic" \
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
	--enable-trace=no \
	--enable-interpreter=no \
	--disable-directfb \
	--enable-ft \
	--enable-gobject \
	--enable-gl \
	--disable-glesv2 \
	--disable-vg \
	--enable-xlib \
	--enable-xcb \
	--with-x \
	--enable-xlib-xrender \
	--enable-ps \
	--enable-pdf \
	--enable-png \
	--disable-script \
	--enable-svg \
	--disable-tee \
	--enable-xml )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/cairo-1.14.10
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/cairo-1.14.10
	@$(call dependency_libs_patch)
	@sed -i "s@\.latomic@\-latomic@g" $(SYSROOT_DIR)/usr/lib/libcairo-gobject.la $(SYSROOT_DIR)/usr/lib/libcairo.la
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/cairo-1.14.10
	@sed -i "s@\.latomic@\-latomic@g" $(ROOTFS_DIR)/usr/lib/libcairo-gobject.la $(ROOTFS_DIR)/usr/lib/libcairo.la
	@rm -rf $(BUILD_DIR)/cairo-1.14.10
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
