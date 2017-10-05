toolchain:
	@$(STEP) "Create toolchain directory."
	@rm -rf $(BUILD_DIR) $(TOOLS_DIR) $(TOOLCHAIN_DEPENDENCIES)
	@mkdir -pv $(BUILD_DIR) $(TOOLS_DIR)
	@ln -svf . $(TOOLS_DIR)/usr
	@make toolchain -C $(PACKAGES_DIR)/gawk
	@make toolchain -C $(PACKAGES_DIR)/m4
	@make toolchain -C $(PACKAGES_DIR)/bison
	@make toolchain -C $(PACKAGES_DIR)/flex
	@make toolchain -C $(PACKAGES_DIR)/binutils
	@make toolchain -C $(PACKAGES_DIR)/gmp
	@make toolchain -C $(PACKAGES_DIR)/mpfr
	@make toolchain -C $(PACKAGES_DIR)/mpc
	@make toolchain -C $(PACKAGES_DIR)/gcc/initial
	@make staging -C $(PACKAGES_DIR)/skeleton
	@make staging -C $(PACKAGES_DIR)/linux
	@make staging -C $(PACKAGES_DIR)/glibc
	@make toolchain -C $(PACKAGES_DIR)/gcc/final
	@make toolchain -C $(PACKAGES_DIR)/ncurses
	@make toolchain -C $(PACKAGES_DIR)/pkgconf
	@make toolchain -C $(PACKAGES_DIR)/libtool
	@make toolchain -C $(PACKAGES_DIR)/autoconf
	@make toolchain -C $(PACKAGES_DIR)/automake
	@make toolchain -C $(PACKAGES_DIR)/texinfo
	@make toolchain -C $(PACKAGES_DIR)/gperf
	@make toolchain -C $(PACKAGES_DIR)/libffi
	@make toolchain -C $(PACKAGES_DIR)/libxml2
	@make toolchain -C $(PACKAGES_DIR)/gettext
	@make toolchain -C $(PACKAGES_DIR)/expat
	@make toolchain -C $(PACKAGES_DIR)/libxml-parser-perl
	@make toolchain -C $(PACKAGES_DIR)/intltool
	@make toolchain -C $(PACKAGES_DIR)/libcap
	@make toolchain -C $(PACKAGES_DIR)/pcre
	@make toolchain -C $(PACKAGES_DIR)/util-linux
	@make toolchain -C $(PACKAGES_DIR)/e2fsprogs
	@make toolchain -C $(PACKAGES_DIR)/zlib
	@make toolchain -C $(PACKAGES_DIR)/python2
	@make toolchain -C $(PACKAGES_DIR)/glib
	@make toolchain -C $(PACKAGES_DIR)/pixman
	@make toolchain -C $(PACKAGES_DIR)/kmod
	@make toolchain -C $(PACKAGES_DIR)/openssl
	@make toolchain -C $(PACKAGES_DIR)/vde2
	@make toolchain -C $(PACKAGES_DIR)/sdl2
	@make toolchain -C $(PACKAGES_DIR)/qemu
	@make toolchain -C $(PACKAGES_DIR)/fakeroot
	@make toolchain -C $(PACKAGES_DIR)/makedevs
	@make toolchain -C $(PACKAGES_DIR)/mkpasswd
	@make toolchain -C $(PACKAGES_DIR)/libconfuse
	@make toolchain -C $(PACKAGES_DIR)/genimage
	@make toolchain -C $(PACKAGES_DIR)/mtools

system:
	@rm -rf $(BUILD_DIR) $(SYSROOT_DIR) $(ROOTFS_DIR) $(SYSTEM_DEPENDENCIES)
	@mkdir -pv $(BUILD_DIR) $(SYSROOT_DIR) $(ROOTFS_DIR)
	@make staging system -C $(PACKAGES_DIR)/skeleton
	@make staging system -C $(PACKAGES_DIR)/linux
	@make staging -C $(PACKAGES_DIR)/glibc
	@make staging-lib system-lib -C $(PACKAGES_DIR)/gcc
	@make system -C $(PACKAGES_DIR)/ncurses
	@make system -C $(PACKAGES_DIR)/readline
	@make system -C $(PACKAGES_DIR)/coreutils
	@make system -C $(PACKAGES_DIR)/bash
	@make system -C $(PACKAGES_DIR)/expat
	@make system -C $(PACKAGES_DIR)/zlib
	@make system -C $(PACKAGES_DIR)/xz
	@make system -C $(PACKAGES_DIR)/kmod
	@make system -C $(PACKAGES_DIR)/libcap
	@make system -C $(PACKAGES_DIR)/util-linux
	@make system -C $(PACKAGES_DIR)/flex
	@make system -C $(PACKAGES_DIR)/linux-pam
	@make system -C $(PACKAGES_DIR)/shadow
	@make system -C $(PACKAGES_DIR)/cacerts
	@make system -C $(PACKAGES_DIR)/openssl
	@make system -C $(PACKAGES_DIR)/wget
	@make system -C $(PACKAGES_DIR)/iana-etc
	@make system -C $(PACKAGES_DIR)/systemd
	@make system -C $(PACKAGES_DIR)/procps-ng
	@make system -C $(PACKAGES_DIR)/dbus
	@make system -C $(PACKAGES_DIR)/vim
	@make system -C $(PACKAGES_DIR)/inetutils
	@make system -C $(PACKAGES_DIR)/dhcpcd
	@make system -C $(PACKAGES_DIR)/debianutils
	@make system -C $(PACKAGES_DIR)/ifupdown
	@make system -C $(PACKAGES_DIR)/tzdata
	@make system -C $(PACKAGES_DIR)/lsb_release
