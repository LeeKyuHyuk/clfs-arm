include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/glibc-2.26.tar.xz
SOURCE_URL := http://ftpmirror.gnu.org/gnu/glibc/glibc-2.26.tar.xz
MD5 := 102f637c3812f81111f48f2427611be1

staging:
	@$(STEP) "glibc 2.26"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@mkdir -p $(BUILD_DIR)/glibc-2.26/glibc-build
	@( cd $(BUILD_DIR)/glibc-2.26/glibc-build && \
	PKG_CONFIG="$(TOOLS_DIR)/bin/pkg-config" \
	AR="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar" \
	CC="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc" \
	RANLIB="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib" \
	BUILD_CC="gcc" \
	$(BUILD_DIR)/glibc-2.26/configure \
	ac_cv_path_BASH_SHELL=/bin/bash \
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
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/glibc-2.26/glibc-build
	@make -j$(CONFIG_PARALLEL_JOBS) install_root=$(SYSROOT_DIR) install -C $(BUILD_DIR)/glibc-2.26/glibc-build
	@echo "#include <gnu/stubs-hard.h>" > $(SYSROOT_DIR)/usr/include/gnu/stubs.h
	@cp -v $(BUILD_DIR)/glibc-2.26/nscd/nscd.conf $(SYSROOT_DIR)/etc/nscd.conf
	@rm -rf $(BUILD_DIR)/glibc-2.26

system:
	@$(STEP) "glibc 2.26"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/glibc/glibc-2.26-fhs-1.patch -d $(BUILD_DIR)/glibc-2.26
	@mkdir -p $(BUILD_DIR)/glibc-2.26/glibc-build
	@( cd $(BUILD_DIR)/glibc-2.26/glibc-build && \
	PKG_CONFIG="$(TOOLS_DIR)/bin/pkg-config" \
	AR="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar" \
	CC="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc" \
	RANLIB="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib" \
	BUILD_CC="gcc" \
	$(BUILD_DIR)/glibc-2.26/configure \
	ac_cv_path_BASH_SHELL=/bin/bash \
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
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/glibc-2.26/glibc-build
	@make -j$(CONFIG_PARALLEL_JOBS) install_root=$(ROOTFS_DIR) install -C $(BUILD_DIR)/glibc-2.26/glibc-build
	@cp -v $(SYSROOT_DIR)/etc/nscd.conf $(ROOTFS_DIR)/etc/nscd.conf
	@mkdir -pv $(ROOTFS_DIR)/var/cache/nscd
	@cp -v $(PACKAGES_DIR)/glibc/nsswitch.conf $(ROOTFS_DIR)/etc/nsswitch.conf
	@cp -v $(PACKAGES_DIR)/glibc/ld.so.conf $(ROOTFS_DIR)/etc/ld.so.conf
	@mkdir -pv $(ROOTFS_DIR)/etc/ld.so.conf.d
	@ln -svf ld-2.26.so $(ROOTFS_DIR)/lib/ld-linux.so.3
	@rm -rf $(BUILD_DIR)/glibc-2.26

system-lib:
	@$(STEP) "glibc 2.26"
	@for libpattern in ld*.so.* libanl.so.* libc.so.* libcrypt.so.* libdl.so.* libgcc_s.so.* libm.so.* libnsl.so.* libpthread.so.* libresolv.so.* librt.so.* libutil.so.* libnss_files.so.* libnss_dns.so.* libmvec.so.*; do \
	LIBPATTERN="$$libpattern"; \
		LIBPATHS=`find $(SYSROOT_DIR)/ -name "$${LIBPATTERN}" 2>/dev/null` ; \
		for LIBPATH in $${LIBPATHS} ; do \
			while true ; do \
				LIBNAME=`basename $${LIBPATH}`; \
				DESTDIR=`echo $${LIBPATH} | sed "s,^$(SYSROOT_DIR)/,," | xargs dirname` ; \
				mkdir -p $(ROOTFS_DIR)/$${DESTDIR}; \
				rm -fr $(ROOTFS_DIR)/$${DESTDIR}/$${LIBNAME}; \
				if test -h $${LIBPATH} ; then \
					cp -dv $${LIBPATH} $(ROOTFS_DIR)/$${DESTDIR}/$${LIBNAME}; \
					LIBPATH="`readlink -f $${LIBPATH}`"; \
				elif test -f $${LIBPATH}; then \
					install -Dv -m0755 $${LIBPATH} $(ROOTFS_DIR)/$${DESTDIR}/$${LIBNAME}; \
					break ; \
				else \
					exit -1; \
				fi; \
			done; \
		done ; \
	done
	@cp -v $(SYSROOT_DIR)/etc/nscd.conf $(ROOTFS_DIR)/etc/nscd.conf
	@mkdir -pv $(ROOTFS_DIR)/var/cache/nscd
	@cp -v $(PACKAGES_DIR)/glibc/nsswitch.conf $(ROOTFS_DIR)/etc/nsswitch.conf
	@cp -v $(PACKAGES_DIR)/glibc/ld.so.conf $(ROOTFS_DIR)/etc/ld.so.conf
	@mkdir -pv $(ROOTFS_DIR)/etc/ld.so.conf.d
	@ln -svf ld-2.26.so $(ROOTFS_DIR)/lib/ld-linux.so.3
