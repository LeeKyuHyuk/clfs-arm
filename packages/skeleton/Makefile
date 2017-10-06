NAME := skeleton

staging:
	@$(STEP) "Create the sysroot directory"
	@mkdir -pv $(SYSROOT_DIR)/dev
	@mkdir -pv $(SYSROOT_DIR)/etc/profile.d
	@ln -snvf ../proc/self/mounts $(SYSROOT_DIR)/etc/mtab
	@ln -snvf ../tmp/resolv.conf $(SYSROOT_DIR)/etc/resolv.conf
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
	@if [[ "$(CONFIG_LINUX_ARCH)" = "arm" ]] ; then \
		ln -snvf lib $(SYSROOT_DIR)/lib32 ; \
		ln -snvf lib $(SYSROOT_DIR)/usr/lib32 ; \
	fi;
	@if [[ "$(CONFIG_LINUX_ARCH)" = "arm64" ]] ; then \
		ln -snvf lib $(SYSROOT_DIR)/lib64 ; \
		ln -snvf lib $(SYSROOT_DIR)/usr/lib64 ; \
	fi;
	@install -dv -m 0755 $(SYSROOT_DIR)/usr/include

system:
	@$(PACKAGES_DIR)/skeleton/create_rootfs.sh
