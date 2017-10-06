include $(SUPPORT_DIR)/functions.mk

NAME := openbox
TARGET_DEPENDENCIES := xlib libxml2 glib pango xinit
SOURCE := $(SOURCES_DIR)/openbox-3.6.1.tar.gz
SOURCE_URL := http://openbox.org/dist/openbox/openbox-3.6.1.tar.gz
MD5 := b72794996c6a3ad94634727b95f9d204

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "openbox 3.6.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np0 -i $(PACKAGES_DIR)/openbox/openbox-aarch64-system-support.patch -d $(BUILD_DIR)/openbox-3.6.1
	@( cd $(BUILD_DIR)/openbox-3.6.1 && \
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
	--sysconfdir=/etc \
	--disable-static \
	--enable-shared )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/openbox-3.6.1
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/openbox-3.6.1
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/openbox-3.6.1
	@install -Dv -m 644 $(PACKAGES_DIR)/openbox/openbox.service $(ROOTFS_DIR)/usr/lib/systemd/system/openbox.service
	@mkdir -p $(ROOTFS_DIR)/etc/systemd/system/multi-user.target.wants
	@ln -fs ../../../../usr/lib/systemd/system/openbox.service $(ROOTFS_DIR)/etc/systemd/system/multi-user.target.wants/openbox.service
	@$(STEP) "Setting automatic login"
	@sed -i 's/^ExecStart.*$$/ExecStart=-\/sbin\/agetty -a clfs %I 38400/' $(ROOTFS_DIR)/lib/systemd/system/getty@.service
	@echo '# Auto start openbox' >> $(ROOTFS_DIR)/etc/profile
	@echo 'if [[ -z $$DISPLAY ]] && [[ $$(tty) = /dev/tty1 ]] && [[ $$USER = clfs ]]; then' >> $(ROOTFS_DIR)/etc/profile
	@echo 'echo -e "\e[1m\e[32mCLFS-ARM booting ... Please wait..!\e[0m"' >> $(ROOTFS_DIR)/etc/profile
	@echo 'exec /usr/bin/startx /usr/bin/openbox-session -- vt1 &> /dev/null' >> $(ROOTFS_DIR)/etc/profile
	@echo 'fi' >> $(ROOTFS_DIR)/etc/profile
	@rm -rf $(BUILD_DIR)/openbox-3.6.1
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
