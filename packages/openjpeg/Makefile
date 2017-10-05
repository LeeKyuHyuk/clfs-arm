include $(SUPPORT_DIR)/functions.mk

NAME := openjpeg
TARGET_DEPENDENCIES := libpng
SOURCE := $(SOURCES_DIR)/openjpeg-1.5.2.tar.gz
SOURCE_URL := https://downloads.sourceforge.net/openjpeg.mirror/openjpeg-1.5.2.tar.gz
MD5 := c41772c30fb1c272358b3707233134a1

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "openjpeg 1.5.2"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/openjpeg-1.5.2 && autoreconf -f -i )
	@( cd $(BUILD_DIR)/openjpeg-1.5.2 && \
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
	--exec-prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--program-prefix="" \
	--disable-static \
	--enable-shared )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/openjpeg-1.5.2
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/openjpeg-1.5.2
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/openjpeg-1.5.2
	@rm -rf $(BUILD_DIR)/openjpeg-1.5.2
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
