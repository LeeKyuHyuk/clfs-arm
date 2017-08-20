staging:
	@$(STEP) "Create the sysroot directory"
	@mkdir -pv $(SYSROOT_DIR)/dev
	@mkdir -pv $(SYSROOT_DIR)/etc/profile.d
	@cp -v $(PACKAGES_DIR)/skeleton/group $(SYSROOT_DIR)/etc/group
	@cp -v $(PACKAGES_DIR)/skeleton/hosts $(SYSROOT_DIR)/etc/hosts
	@ln -snvf ../proc/self/mounts $(SYSROOT_DIR)/etc/mtab
	@cp -v $(PACKAGES_DIR)/skeleton/passwd $(SYSROOT_DIR)/etc/passwd
	@cp -v $(PACKAGES_DIR)/skeleton/profile $(SYSROOT_DIR)/etc/profile
	@cp -v $(PACKAGES_DIR)/skeleton/umask.sh $(SYSROOT_DIR)/etc/profile.d/umask.sh
	@cp -v $(PACKAGES_DIR)/skeleton/protocols $(SYSROOT_DIR)/etc/protocols
	@ln -snvf ../tmp/resolv.conf $(SYSROOT_DIR)/etc/resolv.conf
	@cp -v $(PACKAGES_DIR)/skeleton/services $(SYSROOT_DIR)/etc/services
	@cp -v $(PACKAGES_DIR)/skeleton/shadow $(SYSROOT_DIR)/etc/shadow
	@mkdir -pv $(SYSROOT_DIR)/media
	@mkdir -pv $(SYSROOT_DIR)/mnt
	@mkdir -pv $(SYSROOT_DIR)/opt
	@mkdir -pv $(SYSROOT_DIR)/proc
	@mkdir -pv $(SYSROOT_DIR)/root
	@mkdir -pv $(SYSROOT_DIR)/run
	@mkdir -pv $(SYSROOT_DIR)/sys
	@mkdir -pv $(SYSROOT_DIR)/tmp
	@mkdir -pv $(SYSROOT_DIR)/usr/bin
	@mkdir -pv $(SYSROOT_DIR)/usr/bin
	@mkdir -pv $(SYSROOT_DIR)/usr/sbin
	@mkdir -p $(SYSROOT_DIR)/usr/share/aclocal
	@install -dv -m 0755 $(SYSROOT_DIR)/bin
	@install -dv -m 0755 $(SYSROOT_DIR)/sbin
	@install -dv -m 0755 $(SYSROOT_DIR)/lib
	@ln -snvf lib $(SYSROOT_DIR)/lib32
	@ln -snvf lib $(SYSROOT_DIR)/usr/lib32
	@install -dv -m 0755 $(SYSROOT_DIR)/usr/include

system:
	@$(SCRIPTS_DIR)/create_rootfs.sh

busybox-system:
	@$(STEP) "Create the root file system directory"
	@mkdir -pv $(ROOTFS_DIR)/dev
	@mkdir -pv $(ROOTFS_DIR)/etc/profile.d
	@cp -v $(PACKAGES_DIR)/skeleton/group $(ROOTFS_DIR)/etc/group
	@cp -v $(PACKAGES_DIR)/skeleton/hosts $(ROOTFS_DIR)/etc/hosts
	@ln -snvf ../proc/self/mounts $(ROOTFS_DIR)/etc/mtab
	@cp -v $(PACKAGES_DIR)/skeleton/passwd $(ROOTFS_DIR)/etc/passwd
	@cp -v $(PACKAGES_DIR)/skeleton/profile $(ROOTFS_DIR)/etc/profile
	@cp -v $(PACKAGES_DIR)/skeleton/umask.sh $(ROOTFS_DIR)/etc/profile.d/umask.sh
	@cp -v $(PACKAGES_DIR)/skeleton/protocols $(ROOTFS_DIR)/etc/protocols
	@ln -snvf ../tmp/resolv.conf $(ROOTFS_DIR)/etc/resolv.conf
	@cp -v $(PACKAGES_DIR)/skeleton/services $(ROOTFS_DIR)/etc/services
	@cp -v $(PACKAGES_DIR)/skeleton/shadow $(ROOTFS_DIR)/etc/shadow
	@mkdir -pv $(ROOTFS_DIR)/etc/init.d
	@install -Dv -m 0755 $(PACKAGES_DIR)/skeleton/init.d/* $(ROOTFS_DIR)/etc/init.d/
	@mkdir -pv $(ROOTFS_DIR)/media
	@mkdir -pv $(ROOTFS_DIR)/mnt
	@mkdir -pv $(ROOTFS_DIR)/opt
	@mkdir -pv $(ROOTFS_DIR)/proc
	@mkdir -pv $(ROOTFS_DIR)/root
	@mkdir -pv $(ROOTFS_DIR)/run
	@mkdir -pv $(ROOTFS_DIR)/sys
	@mkdir -pv $(ROOTFS_DIR)/tmp
	@mkdir -pv $(ROOTFS_DIR)/usr/bin
	@mkdir -pv $(ROOTFS_DIR)/usr/bin
	@mkdir -pv $(ROOTFS_DIR)/usr/sbin
	@install -dv -m 0755 $(ROOTFS_DIR)/bin
	@install -dv -m 0755 $(ROOTFS_DIR)/sbin
	@install -dv -m 0755 $(ROOTFS_DIR)/lib
	@ln -snvf lib $(ROOTFS_DIR)/lib32
	@ln -snvf lib $(ROOTFS_DIR)/usr/lib32
	@$(STEP) "Setting the ifupdown scripts."
	@mkdir -pv $(ROOTFS_DIR)/etc/network
	@cp -av $(PACKAGES_DIR)/skeleton/ifupdown-scripts/network/* $(ROOTFS_DIR)/etc/network
	@cp -v $(PACKAGES_DIR)/skeleton/ifupdown-scripts/interfaces $(ROOTFS_DIR)/etc/network/interfaces
	@install -Dv -m 0755 $(PACKAGES_DIR)/skeleton/ifupdown-scripts/nfs_check $(ROOTFS_DIR)/etc/network/nfs_check
	@install -Dv -m 0755 $(PACKAGES_DIR)/skeleton/ifupdown-scripts/S40network $(ROOTFS_DIR)/etc/init.d/S40network
	@$(STEP) "Create the sysvinit system directory"
	@ln -snvf ../tmp/log $(ROOTFS_DIR)/dev/log
	@mkdir -pv $(ROOTFS_DIR)/dev/pts
	@mkdir -pv $(ROOTFS_DIR)/dev/shm
	@cp -v $(PACKAGES_DIR)/skeleton/skeleton-sysv/fstab $(ROOTFS_DIR)/etc/fstab
	@mkdir -pv $(ROOTFS_DIR)/var/lib
	@ln -snvf ../tmp $(ROOTFS_DIR)/var/cache
	@ln -snvf ../../tmp $(ROOTFS_DIR)/var/lib/misc
	@ln -snvf ../tmp $(ROOTFS_DIR)/var/lock
	@ln -snvf ../tmp $(ROOTFS_DIR)/var/log
	@ln -snvf ../tmp $(ROOTFS_DIR)/var/run
	@ln -snvf ../tmp $(ROOTFS_DIR)/var/spool
	@ln -snvf ../tmp $(ROOTFS_DIR)/var/tmp
