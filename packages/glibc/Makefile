include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/glibc-2.25.tar.xz
SOURCE_URL := http://ftp.gnu.org/gnu/glibc/glibc-2.25.tar.xz
MD5 := 1496c3bf41adf9db0ebd0af01f202eed

staging:
	@$(STEP) "glibc 2.25"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@mkdir -p $(BUILD_DIR)/glibc-2.25/glibc-build
	@( cd $(BUILD_DIR)/glibc-2.25/glibc-build && \
	AR="$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar" \
	CC="$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc" \
	RANLIB="$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib" \
	BUILD_CC="gcc" \
	$(BUILD_DIR)/glibc-2.25/configure \
	libc_cv_forced_unwind=yes \
	libc_cv_ssp=no \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--with-pkgversion="$(CONFIG_PKG_VERSION)" \
	--prefix=/usr \
	--enable-obsolete-rpc \
	--enable-kernel=2.6.32 \
	--with-headers=$(SYSROOT_DIR)/usr/include )
	@mkdir -p $(SYSROOT_DIR)/usr/include/gnu
	@touch $(SYSROOT_DIR)/usr/include/gnu/stubs.h
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/glibc-2.25/glibc-build
	@make -j$(CONFIG_PARALLEL_JOBS) install_root=$(SYSROOT_DIR) install -C $(BUILD_DIR)/glibc-2.25/glibc-build
	@echo "#include <gnu/stubs-hard.h>" > $(SYSROOT_DIR)/usr/include/gnu/stubs.h
	@ln -sv ld-2.25.so $(SYSROOT_DIR)/lib/ld-linux.so.3
	@rm -rf $(BUILD_DIR)/glibc-2.25

system:
	@$(STEP) "glibc 2.25"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/glibc/glibc-2.25-fhs-1.patch -d $(BUILD_DIR)/glibc-2.25
	@mkdir -p $(BUILD_DIR)/glibc-2.25/glibc-build
	@( cd $(BUILD_DIR)/glibc-2.25/glibc-build && \
	AR="$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar" \
	CC="$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc" \
	RANLIB="$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib" \
	BUILD_CC="gcc" \
	$(BUILD_DIR)/glibc-2.25/configure \
	libc_cv_slibdir=/lib \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--with-pkgversion="$(CONFIG_PKG_VERSION)" \
	--prefix=/usr \
	--enable-obsolete-rpc \
	--enable-kernel=4.4.45 \
	--enable-stack-protector=strong \
	--with-headers=$(SYSROOT_DIR)/usr/include )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/glibc-2.25/glibc-build
	@touch $(ROOTFS_DIR)/etc/ld.so.conf
	@make -j$(CONFIG_PARALLEL_JOBS) install_root=$(ROOTFS_DIR) install -C $(BUILD_DIR)/glibc-2.25/glibc-build
	@cp -v $(BUILD_DIR)/glibc-2.25/nscd/nscd.conf $(ROOTFS_DIR)/etc/nscd.conf
	@mkdir -pv $(ROOTFS_DIR)/var/cache/nscd
	@cp -v $(PACKAGES_DIR)/glibc/nsswitch.conf $(ROOTFS_DIR)/etc/nsswitch.conf
	@cp -v $(PACKAGES_DIR)/glibc/ld.so.conf $(ROOTFS_DIR)/etc/ld.so.conf
	@mkdir -pv $(ROOTFS_DIR)/etc/ld.so.conf.d
	@ln -svf ld-2.25.so $(ROOTFS_DIR)/lib/ld-linux.so.3
	@rm -rf $(BUILD_DIR)/glibc-2.25
