include settings.mk
-include .config.mk

START_BUILD_TIME := $(shell date +%s)
define PRINT_BUILD_TIME
@time_end=`date +%s` ; time_exec=`awk -v "TS=${START_BUILD_TIME}" -v "TE=$$time_end" 'BEGIN{TD=TE-TS;printf "%02dh:%02dm:%02ds\n",TD/(60*60)%24,TD/(60)%60,TD%60}'` ; $(STEP) "'$@' Build Time: $${time_exec}"
endef

START_TOTAL_BUILD_TIME := $(shell date +%s)
define PRINT_TOTAL_BUILD_TIME
@time_end=`date +%s` ; time_exec=`awk -v "TS=${START_TOTAL_BUILD_TIME}" -v "TE=$$time_end" 'BEGIN{TD=TE-TS;printf "%02dh:%02dm:%02ds\n",TD/(60*60)%24,TD/(60)%60,TD%60}'` ; $(STEP) "Total Build Time: $${time_exec}"
endef


help:
	@$(SCRIPTS_DIR)/help.sh

all:
	@make toolchain
	@make system
	@make kernel
	@make image
	$(PRINT_TOTAL_BUILD_TIME)

%_defconfig:
	@if [ -f $(CONFIG_DIR)/$@ ] ; then \
		cp $(CONFIG_DIR)/$@ .config.mk ; \
		$(SUCCESS) "Load $@." ; \
		make settings ; \
	else \
		$(ERROR) "'$@' configuration file does not exist..." ; \
	fi;

list-defconfigs:
	@first=true; \
	for defconfig in $(CONFIG_DIR)/*_defconfig; do \
		[ -f "$${defconfig}" ] || continue; \
		if $${first}; then \
			echo -e '\e[1mBuilt-in configs:\e[0m' ; \
			first=false; \
		fi; \
		defconfig="$${defconfig##*/}"; \
		printf "  %-35s - Build for %s\n" "$${defconfig}" "$${defconfig%_defconfig}"; \
	done; \
	$${first} || printf "\n"

check:
	@if ! [ -f .config.mk ] ; then \
		echo ; \
		$(ERROR) "Please make defconfig before building." ; \
		$(ERROR) "[ Example ] $ make raspberrypi2_defconfig" ; \
		echo ; \
		exit 1 ; \
	fi;
	@if ! [[ -d $(TOOLS_DIR) ]] ; then \
	    $(ERROR) "Can't find tools directory!" ; \
			$(ERROR) "Run 'make toolchain'." ; \
			exit 1 ; \
	fi;

download:
	@mkdir -pv $(SOURCES_DIR)
	@wget -c -i wget-list -P $(SOURCES_DIR) 2>&1 >/dev/null; true
	$(PRINT_BUILD_TIME)

toolchain:
	@if ! [ -f .config.mk ] ; then \
		echo ; \
		$(ERROR) "Please make defconfig before building." ; \
		$(ERROR) "[Example] $ make raspberrypi2_defconfig" ; \
		echo ; \
		exit 1 ; \
	fi;
	@$(STEP) "Create toolchain directory."
	@rm -rf $(BUILD_DIR) $(TOOLS_DIR)
	@mkdir -pv $(BUILD_DIR) $(TOOLS_DIR)
	@make toolchain -C $(PACKAGES_DIR)/file
	@make toolchain -C $(PACKAGES_DIR)/gawk
	@make toolchain -C $(PACKAGES_DIR)/m4
	@make toolchain -C $(PACKAGES_DIR)/ncurses
	@make toolchain -C $(PACKAGES_DIR)/binutils
	@make toolchain -C $(PACKAGES_DIR)/gcc/initial
	@make staging -C $(PACKAGES_DIR)/linux
	@make staging -C $(PACKAGES_DIR)/glibc
	@make toolchain -C $(PACKAGES_DIR)/gcc/final
	@make toolchain -C $(PACKAGES_DIR)/pkgconf
	@make toolchain -C $(PACKAGES_DIR)/makedevs
	@make toolchain -C $(PACKAGES_DIR)/mke2img
	@make toolchain -C $(PACKAGES_DIR)/genext2fs
	@make toolchain -C $(PACKAGES_DIR)/libconfuse
	@make toolchain -C $(PACKAGES_DIR)/genimage
	@make toolchain -C $(PACKAGES_DIR)/mtools
	@make toolchain -C $(PACKAGES_DIR)/libcap
	@make toolchain -C $(PACKAGES_DIR)/fakeroot
	@make toolchain -C $(PACKAGES_DIR)/mkpasswd
	@make toolchain -C $(PACKAGES_DIR)/zlib
	@make toolchain -C $(PACKAGES_DIR)/libxml2
	@make toolchain -C $(PACKAGES_DIR)/gettext
	@make toolchain -C $(PACKAGES_DIR)/libtool
	@make toolchain -C $(PACKAGES_DIR)/autoconf
	@make toolchain -C $(PACKAGES_DIR)/automake
	@make toolchain -C $(PACKAGES_DIR)/flex
	@make toolchain -C $(PACKAGES_DIR)/bison
	@make toolchain -C $(PACKAGES_DIR)/libffi
	@make toolchain -C $(PACKAGES_DIR)/pcre
	@make toolchain -C $(PACKAGES_DIR)/util-linux
	@make toolchain -C $(PACKAGES_DIR)/glib
	@make toolchain -C $(PACKAGES_DIR)/kmod
	@make toolchain -C $(PACKAGES_DIR)/libpng
	@make toolchain -C $(PACKAGES_DIR)/nasm
	@make toolchain -C $(PACKAGES_DIR)/libjpeg-turbo
	@make toolchain -C $(PACKAGES_DIR)/util-macros
	@make toolchain -C $(PACKAGES_DIR)/gdk-pixbuf
	@make toolchain -C $(PACKAGES_DIR)/libgtk2
	@make toolchain -C $(PACKAGES_DIR)/expat
	@make toolchain -C $(PACKAGES_DIR)/libpciaccess
	@make toolchain -C $(PACKAGES_DIR)/libdrm
	@make toolchain -C $(PACKAGES_DIR)/xorg/xfonts
	@make toolchain -C $(PACKAGES_DIR)/wayland
	@make toolchain-staging
	$(PRINT_BUILD_TIME)

toolchain-staging:
	@make check
	@rm -rf $(BUILD_DIR) $(SYSROOT_DIR)
	@mkdir -pv $(BUILD_DIR)	$(SYSROOT_DIR)
	@make staging -C $(PACKAGES_DIR)/linux
	@make staging -C $(PACKAGES_DIR)/glibc
	@make staging -C $(PACKAGES_DIR)/zlib
	@make staging -C $(PACKAGES_DIR)/binutils
	@make staging -C $(PACKAGES_DIR)/gcc
	@make staging -C $(PACKAGES_DIR)/ncurses
	@make staging -C $(PACKAGES_DIR)/readline
	@make staging -C $(PACKAGES_DIR)/libffi
	@make staging -C $(PACKAGES_DIR)/pcre
	@make staging -C $(PACKAGES_DIR)/glib
	@make staging -C $(PACKAGES_DIR)/xz
	@make staging -C $(PACKAGES_DIR)/util-linux
	@make staging -C $(PACKAGES_DIR)/libpipeline
	@make staging -C $(PACKAGES_DIR)/gdbm
	@make staging -C $(PACKAGES_DIR)/libcap
	@make staging -C $(PACKAGES_DIR)/openssl
	@make staging -C $(PACKAGES_DIR)/linux-pam
	@make staging -C $(PACKAGES_DIR)/libxml2
	@make staging -C $(PACKAGES_DIR)/libpng
	@make staging -C $(PACKAGES_DIR)/nasm
	@make staging -C $(PACKAGES_DIR)/libjpeg-turbo
	@make staging -C $(PACKAGES_DIR)/atk
	@make staging -C $(PACKAGES_DIR)/gdk-pixbuf
	@make staging -C $(PACKAGES_DIR)/freetype
	@make staging -C $(PACKAGES_DIR)/harfbuzz
	@make staging -C $(PACKAGES_DIR)/freetype
	@make staging -C $(PACKAGES_DIR)/fontconfig
	@make staging -C $(PACKAGES_DIR)/pixman
	@make staging -C $(PACKAGES_DIR)/util-macros
	@make staging -C $(PACKAGES_DIR)/xorg/xproto
	@make staging -C $(PACKAGES_DIR)/libxau
	@make staging -C $(PACKAGES_DIR)/xcb-proto
	@make staging -C $(PACKAGES_DIR)/libxcb
	@make staging -C $(PACKAGES_DIR)/xorg/xlib
	@make staging -C $(PACKAGES_DIR)/cairo
	@make staging -C $(PACKAGES_DIR)/pango
	@make staging -C $(PACKAGES_DIR)/hicolor-icon-theme
	@make staging -C $(PACKAGES_DIR)/libgtk2
	@make staging -C $(PACKAGES_DIR)/mtdev
	@make staging -C $(PACKAGES_DIR)/xkeyboard-config
	@make staging -C $(PACKAGES_DIR)/libxkbcommon
	@make staging -C $(PACKAGES_DIR)/libevdev
	@make staging -C $(PACKAGES_DIR)/eudev
	@make staging -C $(PACKAGES_DIR)/libinput
	@make staging -C $(PACKAGES_DIR)/libpciaccess
	@make staging -C $(PACKAGES_DIR)/libdrm
	@make staging -C $(PACKAGES_DIR)/expat
	@make staging -C $(PACKAGES_DIR)/wayland
	@make staging -C $(PACKAGES_DIR)/wayland-protocols
	@make staging -C $(PACKAGES_DIR)/mesa
	@make staging -C $(PACKAGES_DIR)/libunwind
	@make staging -C $(PACKAGES_DIR)/libepoxy
	@make staging -C $(PACKAGES_DIR)/weston
	@make staging -C $(PACKAGES_DIR)/xorg/xfonts
	@make staging -C $(PACKAGES_DIR)/xorg/xserver
	@make staging -C $(PACKAGES_DIR)/xorg/xdriver/xf86-input-evdev
	@make staging -C $(PACKAGES_DIR)/xorg/xdriver/xf86-input-libinput
	$(PRINT_BUILD_TIME)

system:
	@make check
	@rm -rf $(BUILD_DIR) $(ROOTFS_DIR)
	@mkdir -pv $(BUILD_DIR) $(ROOTFS_DIR)
	@make system -C $(PACKAGES_DIR)/skeleton
	@make system -C $(PACKAGES_DIR)/linux
	@make system -C $(PACKAGES_DIR)/man-pages
	@make system -C $(PACKAGES_DIR)/zlib
	@make system -C $(PACKAGES_DIR)/file
	@make system -C $(PACKAGES_DIR)/ncurses
	@make system -C $(PACKAGES_DIR)/readline
	@make system -C $(PACKAGES_DIR)/m4
	@make system -C $(PACKAGES_DIR)/bc
	@make system -C $(PACKAGES_DIR)/binutils
	@make system -C $(PACKAGES_DIR)/gcc
	@make system -C $(PACKAGES_DIR)/bzip2
	@make system -C $(PACKAGES_DIR)/libffi
	@make system -C $(PACKAGES_DIR)/pcre
	@make system -C $(PACKAGES_DIR)/glib
	@make system -C $(PACKAGES_DIR)/pkg-config
	@make system -C $(PACKAGES_DIR)/sed
	@make system -C $(PACKAGES_DIR)/shadow
	@make system -C $(PACKAGES_DIR)/psmisc
	@make system -C $(PACKAGES_DIR)/iana-etc
	@make system -C $(PACKAGES_DIR)/bison
	@make system -C $(PACKAGES_DIR)/flex
	@make system -C $(PACKAGES_DIR)/grep
	@make system -C $(PACKAGES_DIR)/bash
	@make system -C $(PACKAGES_DIR)/libtool
	@make system -C $(PACKAGES_DIR)/gdbm
	@make system -C $(PACKAGES_DIR)/gperf
	@make system -C $(PACKAGES_DIR)/inetutils
	@make system -C $(PACKAGES_DIR)/autoconf
	@make system -C $(PACKAGES_DIR)/automake
	@make system -C $(PACKAGES_DIR)/xz
	@make system -C $(PACKAGES_DIR)/kmod
	@make system -C $(PACKAGES_DIR)/gettext
	@make system -C $(PACKAGES_DIR)/procps-ng
	@make system -C $(PACKAGES_DIR)/util-linux
	@make system -C $(PACKAGES_DIR)/e2fsprogs
	@make system -C $(PACKAGES_DIR)/coreutils
	@make system -C $(PACKAGES_DIR)/diffutils
	@make system -C $(PACKAGES_DIR)/gawk
	@make system -C $(PACKAGES_DIR)/findutils
	@make system -C $(PACKAGES_DIR)/less
	@make system -C $(PACKAGES_DIR)/gzip
	@make system -C $(PACKAGES_DIR)/iproute2
	@make system -C $(PACKAGES_DIR)/kbd
	@make system -C $(PACKAGES_DIR)/libpipeline
	@make system -C $(PACKAGES_DIR)/make
	@make system -C $(PACKAGES_DIR)/patch
	@make system -C $(PACKAGES_DIR)/sysklogd
	@make system -C $(PACKAGES_DIR)/sysvinit
	@make system -C $(PACKAGES_DIR)/eudev
	@make system -C $(PACKAGES_DIR)/tar
	@make system -C $(PACKAGES_DIR)/texinfo
	@make system -C $(PACKAGES_DIR)/vim
	@make system -C $(PACKAGES_DIR)/tzdata
	@make system -C $(PACKAGES_DIR)/bootscripts
	@make system -C $(PACKAGES_DIR)/libcap
	@make system -C $(PACKAGES_DIR)/openssl
	@make system -C $(PACKAGES_DIR)/openssh
	@make system -C $(PACKAGES_DIR)/ntp
	@make system -C $(PACKAGES_DIR)/lsb-release
	@make system -C $(PACKAGES_DIR)/linux-pam
	@make system -C $(PACKAGES_DIR)/libxml2
	@make system -C $(PACKAGES_DIR)/libpng
	@make system -C $(PACKAGES_DIR)/nasm
	@make system -C $(PACKAGES_DIR)/libjpeg-turbo
	@make system -C $(PACKAGES_DIR)/atk
	@make system -C $(PACKAGES_DIR)/gdk-pixbuf
	@make system -C $(PACKAGES_DIR)/freetype
	@make system -C $(PACKAGES_DIR)/harfbuzz
	@make system -C $(PACKAGES_DIR)/freetype
	@make system -C $(PACKAGES_DIR)/fontconfig
	@make system -C $(PACKAGES_DIR)/pixman
	@make system -C $(PACKAGES_DIR)/util-macros
	@make system -C $(PACKAGES_DIR)/xorg/xproto
	@make system -C $(PACKAGES_DIR)/libxau
	@make system -C $(PACKAGES_DIR)/xcb-proto
	@make system -C $(PACKAGES_DIR)/libxcb
	@make system -C $(PACKAGES_DIR)/xorg/xlib
	@make system -C $(PACKAGES_DIR)/cairo
	@make system -C $(PACKAGES_DIR)/pango
	@make system -C $(PACKAGES_DIR)/hicolor-icon-theme
	@make system -C $(PACKAGES_DIR)/libgtk2
	@make system -C $(PACKAGES_DIR)/mtdev
	@make system -C $(PACKAGES_DIR)/xkeyboard-config
	@make system -C $(PACKAGES_DIR)/libxkbcommon
	@make system -C $(PACKAGES_DIR)/libevdev
	@make system -C $(PACKAGES_DIR)/libinput
	@make system -C $(PACKAGES_DIR)/libpciaccess
	@make system -C $(PACKAGES_DIR)/libdrm
	@make system -C $(PACKAGES_DIR)/wayland
	@make system -C $(PACKAGES_DIR)/wayland-protocols
	@make system -C $(PACKAGES_DIR)/mesa
	@make system -C $(PACKAGES_DIR)/libunwind
	@make system -C $(PACKAGES_DIR)/libepoxy
	@make system -C $(PACKAGES_DIR)/expat
	@make system -C $(PACKAGES_DIR)/weston
	@make system -C $(PACKAGES_DIR)/xorg/xserver
	@make system -C $(PACKAGES_DIR)/xorg/xdriver/xf86-input-evdev
	@make system -C $(PACKAGES_DIR)/xorg/xdriver/xf86-input-libinput
	@make system -C $(PACKAGES_DIR)/xorg/xdriver/xf86-input-mouse
	@make system -C $(PACKAGES_DIR)/xorg/xdriver/xf86-input-keyboard
	@make system -C $(PACKAGES_DIR)/xorg/xdriver/xf86-video-fbdev
	@make system -C $(PACKAGES_DIR)/glibc
	$(PRINT_BUILD_TIME)

kernel:
	@make check
	@rm -rf $(BUILD_DIR) $(KERNEL_DIR)
	@mkdir -pv $(BUILD_DIR) $(KERNEL_DIR)
	@make kernel -C $(PACKAGES_DIR)/linux
	$(PRINT_BUILD_TIME)

image:
	@make check
	@rm -rf $(BUILD_DIR) $(IMAGES_DIR)
	@mkdir -pv $(BUILD_DIR) $(IMAGES_DIR)
	@$(CONFIG_IMAGE_SCRIPT)
	$(PRINT_BUILD_TIME)

settings:
	@$(SCRIPTS_DIR)/settings.sh

run:
	@if ! [[ "$(CONFIG_NAME)" = "qemu_vexpress" ]] ; then \
		$(ERROR) "QEMU Emulate only supports 'qemu_vexpress'." ; \
		exit 1 ; \
	fi;
	@qemu-system-arm -M vexpress-a9 -smp 1 -m 256 -kernel $(KERNEL_DIR)/zImage -dtb $(KERNEL_DIR)/vexpress-v2p-ca9.dtb -drive file=$(IMAGES_DIR)/rootfs.ext2,if=sd,format=raw -append "console=ttyAMA0,115200 root=/dev/mmcblk0 ip=dhcp" -serial stdio -net nic,model=lan9118 -net user -show-cursor

flash:
	@chmod 755 $(DEVICE_DIR)/raspberrypi/image-usb-stick
	@sudo $(DEVICE_DIR)/raspberrypi/image-usb-stick $(IMAGES_DIR)/sdcard.img
	@sudo -k
	$(PRINT_BUILD_TIME)

clean:
	@rm -rf .config.mk $(OUTPUT_DIR)
