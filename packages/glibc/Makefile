include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/glibc-2.25.tar.xz
SOURCE_URL := http://ftpmirror.gnu.org/gnu/glibc/glibc-2.25.tar.xz
MD5 := 1496c3bf41adf9db0ebd0af01f202eed

staging:
	@$(STEP) "glibc 2.25"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/glibc/CVE-2017-1000366-Ignore-LD_LIBRARY_PATH-for-AT_SECUR.patch -d $(BUILD_DIR)/glibc-2.25
	@patch -Np1 -i $(PACKAGES_DIR)/glibc/ld.so-Reject-overly-long-LD_PRELOAD-path-elements.patch -d $(BUILD_DIR)/glibc-2.25
	@patch -Np1 -i $(PACKAGES_DIR)/glibc/ld.so-Reject-overly-long-LD_AUDIT-path-elements.patch -d $(BUILD_DIR)/glibc-2.25
	@patch -Np1 -i $(PACKAGES_DIR)/glibc/fix-binutils-2-29-build.patch -d $(BUILD_DIR)/glibc-2.25
	@patch -Np1 -i $(PACKAGES_DIR)/glibc/sh4-trap.patch -d $(BUILD_DIR)/glibc-2.25
	@mkdir -p $(BUILD_DIR)/glibc-2.25/glibc-build
	@( cd $(BUILD_DIR)/glibc-2.25/glibc-build && \
	PKG_CONFIG="$(TOOLS_DIR)/bin/pkg-config" \
	AR="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar" \
	CC="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc" \
	RANLIB="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib" \
	BUILD_CC="gcc" \
	$(BUILD_DIR)/glibc-2.25/configure \
	ac_cv_path_BASH_SHELL=/bin/bash \
	libc_cv_forced_unwind=yes \
	libc_cv_ssp=no \
	libc_cv_slibdir=/lib \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--with-pkgversion="$(CONFIG_PKG_VERSION)" \
	--prefix=/usr \
	--enable-obsolete-rpc \
	--enable-kernel=3.2 \
	--with-headers=$(SYSROOT_DIR)/usr/include )
	@mkdir -p $(SYSROOT_DIR)/usr/include/gnu
	@touch $(SYSROOT_DIR)/usr/include/gnu/stubs.h
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/glibc-2.25/glibc-build
	@sed '/test-installation/s@$(PERL)@echo not running@' -i $(BUILD_DIR)/glibc-2.25/Makefile
	@make -j$(CONFIG_PARALLEL_JOBS) install_root=$(SYSROOT_DIR) install -C $(BUILD_DIR)/glibc-2.25/glibc-build
	@cp -v $(BUILD_DIR)/glibc-2.25/nscd/nscd.conf $(SYSROOT_DIR)/etc/nscd.conf
	@mkdir -pv $(SYSROOT_DIR)/usr/lib/tmpfiles.d $(SYSROOT_DIR)/lib/systemd/system
	@install -v -Dm644 $(BUILD_DIR)/glibc-2.25/nscd/nscd.tmpfiles $(SYSROOT_DIR)/usr/lib/tmpfiles.d/nscd.conf
	@install -v -Dm644 $(BUILD_DIR)/glibc-2.25/nscd/nscd.service $(SYSROOT_DIR)/lib/systemd/system/nscd.service
	@cp -v $(PACKAGES_DIR)/glibc/nsswitch.conf $(SYSROOT_DIR)/etc/nsswitch.conf
	@cp -v $(PACKAGES_DIR)/glibc/ld.so.conf $(SYSROOT_DIR)/etc/ld.so.conf
	@mkdir -pv $(SYSROOT_DIR)/etc/ld.so.conf.d
	@rm -rf $(BUILD_DIR)/glibc-2.25

system:
	@$(STEP) "glibc 2.25"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/glibc/CVE-2017-1000366-Ignore-LD_LIBRARY_PATH-for-AT_SECUR.patch -d $(BUILD_DIR)/glibc-2.25
	@patch -Np1 -i $(PACKAGES_DIR)/glibc/ld.so-Reject-overly-long-LD_PRELOAD-path-elements.patch -d $(BUILD_DIR)/glibc-2.25
	@patch -Np1 -i $(PACKAGES_DIR)/glibc/ld.so-Reject-overly-long-LD_AUDIT-path-elements.patch -d $(BUILD_DIR)/glibc-2.25
	@patch -Np1 -i $(PACKAGES_DIR)/glibc/fix-binutils-2-29-build.patch -d $(BUILD_DIR)/glibc-2.25
	@patch -Np1 -i $(PACKAGES_DIR)/glibc/sh4-trap.patch -d $(BUILD_DIR)/glibc-2.25
	@patch -Np1 -i $(PACKAGES_DIR)/glibc/glibc-2.25-fhs-1.patch -d $(BUILD_DIR)/glibc-2.25
	@mkdir -p $(BUILD_DIR)/glibc-2.25/glibc-build
	@( cd $(BUILD_DIR)/glibc-2.25/glibc-build && \
	PKG_CONFIG="$(TOOLS_DIR)/bin/pkg-config" \
	AR="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar" \
	CC="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc" \
	RANLIB="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib" \
	BUILD_CC="gcc" \
	$(BUILD_DIR)/glibc-2.25/configure \
	ac_cv_path_BASH_SHELL=/bin/bash \
	libc_cv_forced_unwind=yes \
	libc_cv_ssp=no \
	libc_cv_slibdir=/lib \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--with-pkgversion="$(CONFIG_PKG_VERSION)" \
	--prefix=/usr \
	--enable-obsolete-rpc \
	--enable-kernel=3.2 \
	--with-headers=$(SYSROOT_DIR)/usr/include )
	@mkdir -p $(SYSROOT_DIR)/usr/include/gnu
	@touch $(SYSROOT_DIR)/usr/include/gnu/stubs.h
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/glibc-2.25/glibc-build
	@sed '/test-installation/s@$(PERL)@echo not running@' -i $(BUILD_DIR)/glibc-2.25/Makefile
	@make -j$(CONFIG_PARALLEL_JOBS) install_root=$(ROOTFS_DIR) install -C $(BUILD_DIR)/glibc-2.25/glibc-build
	@cp -v $(SYSROOT_DIR)/etc/nscd.conf $(ROOTFS_DIR)/etc/nscd.conf
	@mkdir -pv $(ROOTFS_DIR)/var/cache/nscd
	@install -v -Dm644 $(SYSROOT_DIR)/usr/lib/tmpfiles.d/nscd.conf $(ROOTFS_DIR)/usr/lib/tmpfiles.d/nscd.conf
	@install -v -Dm644 $(SYSROOT_DIR)/lib/systemd/system/nscd.service $(ROOTFS_DIR)/lib/systemd/system/nscd.service
	@cp -v $(PACKAGES_DIR)/glibc/nsswitch.conf $(ROOTFS_DIR)/etc/nsswitch.conf
	@cp -v $(PACKAGES_DIR)/glibc/ld.so.conf $(ROOTFS_DIR)/etc/ld.so.conf
	@mkdir -pv $(ROOTFS_DIR)/etc/ld.so.conf.d
	@ln -svf ld-2.25.so $(ROOTFS_DIR)/lib/ld-linux.so.3
	@rm -rf $(BUILD_DIR)/glibc-2.25

system-lib:
	@$(STEP) "glibc 2.25"
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
	@ln -svf ld-2.25.so $(ROOTFS_DIR)/lib/ld-linux.so.3
