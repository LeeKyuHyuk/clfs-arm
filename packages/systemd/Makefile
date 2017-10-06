include $(SUPPORT_DIR)/functions.mk

NAME := systemd
TARGET_DEPENDENCIES := libcap util-linux kmod linux-pam
SOURCE := $(PACKAGES_DIR)/systemd/systemd-234.tar.gz
SOURCE_URL := https://github.com/systemd/systemd/archive/v234.tar.gz
MD5 := 2d8f6ebded3462ac0d1a6275e54db561

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "systemd 234"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/systemd/build-check-for-ln-relative.patch -d $(BUILD_DIR)/systemd-234
	@patch -Np1 -i $(PACKAGES_DIR)/systemd/fix-am-path-libgcrypt-no-found.patch -d $(BUILD_DIR)/systemd-234
	@sed -i "s@\"Linux\"@\"CLFS-ARM\"@g" $(BUILD_DIR)/systemd-234/src/core/main.c
	@( cd $(BUILD_DIR)/systemd-234 && $(TOOLS_DIR)/bin/intltoolize --force --automake )
	@( cd $(BUILD_DIR)/systemd-234 && autoreconf --install )
	@( cd $(BUILD_DIR)/systemd-234 && \
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
	CXX=false \
	CFLAGS="-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -Os -fno-lto" \
	ac_cv_path_KILL=/bin/kill \
	ac_cv_path_KMOD=/bin/kmod \
	ac_cv_path_KEXEC=/usr/sbin/kexec \
	ac_cv_path_SULOGIN=/sbin/sulogin \
	ac_cv_path_MOUNT_PATH=/bin/mount \
	ac_cv_path_UMOUNT_PATH=/bin/umount \
	ac_cv_path_QUOTAON=/.missing \
	ac_cv_path_QUOTACHECK=/.missing \
	CONFIG_SITE=/dev/null \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--with-rootprefix= \
	--with-rootlibdir=/lib \
	--disable-manpages \
	--disable-tests \
	--enable-split-usr \
	--disable-firstboot \
	--disable-ldconfig \
	--disable-sysusers \
	--without-python \
	--with-default-dnssec=no )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/systemd-234
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/systemd-234
	@rm -rfv $(SYSROOT_DIR)/usr/lib/rpm
	@for lib in $(SYSROOT_DIR)/lib/*.la ; do \
		while ! [ `grep " /usr/lib/\(.*\).la" $${lib}` -n ] ; do \
			sed -i "s@ /usr/lib/\(.*\).la@ $(SYSROOT_DIR)/usr/lib/\1.la@g" $${lib} ; \
		done ; \
	done;
	@for lib in $(SYSROOT_DIR)/lib/systemd/*.la ; do \
		while ! [ `grep " /usr/lib/\(.*\).la" $${lib}` -n ] ; do \
			sed -i "s@ /usr/lib/\(.*\).la@ $(SYSROOT_DIR)/usr/lib/\1.la@g" $${lib} ; \
		done ; \
	done;
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/systemd-234
	@rm -rfv $(ROOTFS_DIR)/usr/lib/rpm
	@for tool in runlevel reboot shutdown poweroff halt telinit; do \
		ln -sfv ../bin/systemctl $(ROOTFS_DIR)/sbin/$${tool} ; \
	done
	@ln -sfv ../lib/systemd/systemd $(ROOTFS_DIR)/sbin/init
	@sed s/SYSTEMD_NETWORKD_DHCP_IFACE/$(SYSTEMD_NETWORKD_DHCP_IFACE)/ $(PACKAGES_DIR)/systemd/dhcp.network > $(ROOTFS_DIR)/etc/systemd/network/dhcp.network
	@install -Dv -m 644 $(PACKAGES_DIR)/systemd/network.service $(ROOTFS_DIR)/etc/systemd/system/network.service
	@mkdir -p $(ROOTFS_DIR)/etc/systemd/system/multi-user.target.wants
	@ln -fs ../network.service $(ROOTFS_DIR)/etc/systemd/system/multi-user.target.wants/network.service
	@touch $(ROOTFS_DIR)/etc/machine-id
	@ln -sfv /run/systemd/resolve/resolv.conf $(ROOTFS_DIR)/etc/resolv.conf
	@cp -v $(PACKAGES_DIR)/systemd/83-duplicate_devs.rules $(ROOTFS_DIR)/etc/udev/rules.d/83-duplicate_devs.rules
	@cp -v $(PACKAGES_DIR)/systemd/adjtime $(ROOTFS_DIR)/etc/adjtime
	@cp -v $(PACKAGES_DIR)/linux-pam/systemd-user $(ROOTFS_DIR)/etc/pam.d/
	@rm -rf $(BUILD_DIR)/systemd-234
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
