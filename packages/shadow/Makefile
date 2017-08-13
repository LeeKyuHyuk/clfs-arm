include $(SUPPORT_DIR)/functions.mk

SOURCE := $(PACKAGES_DIR)/shadow/shadow-4.4.tar.xz
SOURCE_URL := https://github.com/shadow-maint/shadow/releases/download/4.4/shadow-4.4.tar.xz
MD5 := c06f8c2571b44899e60662f9ad259dd6

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "shadow 4.4"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -i 's/groups$(EXEEXT) //' $(BUILD_DIR)/shadow-4.4/src/Makefile.in
	@find $(BUILD_DIR)/shadow-4.4/man -name Makefile.in -exec sed -i 's/groups\.1 / /'   {} \;
	@find $(BUILD_DIR)/shadow-4.4/man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \;
	@find $(BUILD_DIR)/shadow-4.4/man -name Makefile.in -exec sed -i 's/passwd\.5 / /'   {} \;
	@sed -i -e 's|#ENCRYPT_METHOD DES|ENCRYPT_METHOD SHA512|' -e 's|/var/spool/mail|/var/mail|' $(BUILD_DIR)/shadow-4.4/etc/login.defs
	@patch -Np0 -l -i $(PACKAGES_DIR)/shadow/shadow-4.4_1.patch -d $(BUILD_DIR)/shadow-4.4
	@sed -i 's/1000/999/' $(BUILD_DIR)/shadow-4.4/etc/useradd
	@sed -i -e '47 d' -e '60,65 d' $(BUILD_DIR)/shadow-4.4/libmisc/myname.c
	@( cd $(BUILD_DIR)/shadow-4.4 && \
	PKG_CONFIG="$(TOOLS_DIR)/usr/bin/pkg-config" \
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
	--sysconfdir=/etc \
	--with-group-name-max-length=32 )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/shadow-4.4
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/shadow-4.4
	@sed -i 's/yes/no/' $(ROOTFS_DIR)/etc/default/useradd
	@rm -rf $(BUILD_DIR)/shadow-4.4
