include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/lxdm-0.5.3.tar.xz
SOURCE_URL := https://downloads.sourceforge.net/lxdm/lxdm-0.5.3.tar.xz
MD5 := 061caae432634e6db38bbdc84bc6ffa0

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "lxdm 0.5.3"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@cp -v $(PACKAGES_DIR)/lxdm/lxdm $(BUILD_DIR)/lxdm-0.5.3/pam/lxdm
	@sed -i 's:sysconfig/i18n:profile.d/i18n.sh:g' $(BUILD_DIR)/lxdm-0.5.3/data/lxdm.in
	@sed -i 's:/etc/xprofile:/etc/profile:g' $(BUILD_DIR)/lxdm-0.5.3/data/Xsession
	@sed -e 's/^bg/#&/' -e '/reset=1/ s/# //' -e 's/logou$$/logout/' -e "/arg=/a arg=/usr/bin/X" -i $(BUILD_DIR)/lxdm-0.5.3/data/lxdm.conf.in
	@( cd $(BUILD_DIR)/lxdm-0.5.3 && \
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
	--enable-shared \
	--with-pam \
	--with-systemdsystemunitdir=/lib/systemd/system )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/lxdm-0.5.3
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/lxdm-0.5.3
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/lxdm-0.5.3
	@mkdir -p $(ROOTFS_DIR)/etc/systemd/system/multi-user.target.wants
	@ln -sfv /lib/systemd/system/lxdm.service $(ROOTFS_DIR)/etc/systemd/system/multi-user.target.wants/lxdm.service
	@rm -rf $(BUILD_DIR)/lxdm-0.5.3
