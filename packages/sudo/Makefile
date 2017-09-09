include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/sudo-1.8.21p1.tar.gz
SOURCE_URL := http://www.sudo.ws/dist/sudo-1.8.21p1.tar.gz
MD5 := bc58437f3f73b598263436dc58722b2a

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "sudo 1.8.21p1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/sudo-1.8.21p1 && \
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
	--libexecdir=/usr/lib \
	--program-prefix="" \
	--disable-static \
	--enable-shared \
	--without-lecture \
	--without-sendmail \
	--without-umask \
	--without-interfaces \
	--with-secure-path \
	--with-all-insults \
	--with-env-editor \
	--with-passprompt="[sudo] password for %p: " )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/sudo-1.8.21p1
	@make -j$(CONFIG_PARALLEL_JOBS) INSTALL_OWNER="" DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/sudo-1.8.21p1
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) INSTALL_OWNER="" DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/sudo-1.8.21p1
	@ln -sfv libsudo_util.so.0.0.0 $(ROOTFS_DIR)/usr/lib/sudo/libsudo_util.so.0
	@cp -v $(PACKAGES_DIR)/sudo/sudo $(ROOTFS_DIR)/etc/pam.d/sudo
	@rm -rf $(BUILD_DIR)/sudo-1.8.21p1
