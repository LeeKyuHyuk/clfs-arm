include $(SUPPORT_DIR)/functions.mk

SOURCE := $(PACKAGES_DIR)/systemd/systemd-234-lfs.tar.xz
SOURCE_URL := http://anduin.linuxfromscratch.org/LFS/systemd-234-lfs.tar.xz
MD5 := be1338f2775713dc33da74ac0146e37b

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
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -i "s@\"Linux\"@\"CLFS-ARM\"@g" $(BUILD_DIR)/systemd-234-lfs/src/core/main.c
	@( cd $(BUILD_DIR)/systemd-234-lfs && \
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
	ac_cv_path_KILL=/usr/bin/kill \
	ac_cv_path_KMOD=/usr/bin/kmod \
	ac_cv_path_KEXEC=/usr/sbin/kexec \
	ac_cv_path_SULOGIN=/usr/sbin/sulogin \
	ac_cv_path_MOUNT_PATH=/usr/bin/mount \
	ac_cv_path_UMOUNT_PATH=/usr/bin/umount \
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
	--config-cache \
	--with-rootprefix= \
	--with-rootlibdir=/lib \
	--enable-split-usr \
	--disable-firstboot \
	--disable-ldconfig \
	--disable-sysusers \
	--without-python \
	--with-default-dnssec=no )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/systemd-234-lfs
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/systemd-234-lfs
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
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/systemd-234-lfs
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
	@rm -rf $(BUILD_DIR)/systemd-234-lfs
