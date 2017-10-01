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

toolchain:
	@if ! [ -f .config.mk ] ; then \
		echo ; \
		$(ERROR) "Please make defconfig before building." ; \
		$(ERROR) "[Example] $ make raspberrypi2_defconfig" ; \
		echo ; \
		exit 1 ; \
	fi;
	@make toolchain -C $(SUPPORT_DIR)/systemd # Essential Toolchain Package
	@make toolchain -C $(PACKAGES_DIR)/dbus-glib
	@make toolchain -C $(PACKAGES_DIR)/util-macros
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto
	@make toolchain -C $(PACKAGES_DIR)/libpthread-stubs
	@make toolchain -C $(PACKAGES_DIR)/libxdmcp
	@make toolchain -C $(PACKAGES_DIR)/libxau
	@make toolchain -C $(PACKAGES_DIR)/libxcb
	@make toolchain -C $(PACKAGES_DIR)/libpng
	@make toolchain -C $(PACKAGES_DIR)/freetype
	@make toolchain -C $(PACKAGES_DIR)/fontconfig
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib
	@make toolchain -C $(PACKAGES_DIR)/font-util
	@make toolchain -C $(PACKAGES_DIR)/gdk-pixbuf
	@make toolchain -C $(PACKAGES_DIR)/libgtk2
	@make toolchain -C $(PACKAGES_DIR)/curl
	@make toolchain -C $(PACKAGES_DIR)/cmake
	@make toolchain -C $(PACKAGES_DIR)/pixman
	@make toolchain -C $(PACKAGES_DIR)/cairo
	@make toolchain -C $(PACKAGES_DIR)/harfbuzz
	@make toolchain -C $(PACKAGES_DIR)/pango
	@make toolchain -C $(PACKAGES_DIR)/libcroco
	@make toolchain -C $(PACKAGES_DIR)/librsvg
	@make toolchain -C $(PACKAGES_DIR)/vala
	@make toolchain -C $(PACKAGES_DIR)/itstool
	$(PRINT_BUILD_TIME)

system:
	@make check
	@make system -C $(SUPPORT_DIR)/systemd # Essential System Package
	@make system -C $(PACKAGES_DIR)/dbus-glib
	@make system -C $(PACKAGES_DIR)/openssl
	@make system -C $(PACKAGES_DIR)/openssh
	@make system -C $(PACKAGES_DIR)/cacerts
	@make system -C $(PACKAGES_DIR)/wget
	@make system -C $(PACKAGES_DIR)/ntp
	@make system -C $(PACKAGES_DIR)/which
	@make system -C $(PACKAGES_DIR)/util-macros
	@make system -C $(PACKAGES_DIR)/xorg/proto
	@make system -C $(PACKAGES_DIR)/xcb-proto
	@make system -C $(PACKAGES_DIR)/libpthread-stubs
	@make system -C $(PACKAGES_DIR)/libxdmcp
	@make system -C $(PACKAGES_DIR)/libxau
	@make system -C $(PACKAGES_DIR)/libxcb
	@make system -C $(PACKAGES_DIR)/libjpeg-turbo
	@make system -C $(PACKAGES_DIR)/libpng
	@make system -C $(PACKAGES_DIR)/freetype
	@make system -C $(PACKAGES_DIR)/fontconfig
	@make system -C $(PACKAGES_DIR)/xorg/lib
	@make system -C $(PACKAGES_DIR)/xcb-util
	@make system -C $(PACKAGES_DIR)/icu
	@make system -C $(PACKAGES_DIR)/libxkbcommon
	@make system -C $(PACKAGES_DIR)/xkbcomp
	@make system -C $(PACKAGES_DIR)/xkeyboard-config
	@make system -C $(PACKAGES_DIR)/libevdev
	@make system -C $(PACKAGES_DIR)/mtdev
	@make system -C $(PACKAGES_DIR)/libinput
	@make system -C $(PACKAGES_DIR)/libdrm
	@make system -C $(PACKAGES_DIR)/mesa
	@make system -C $(PACKAGES_DIR)/libepoxy
	@make system -C $(PACKAGES_DIR)/pixman
	@make system -C $(PACKAGES_DIR)/cairo
	@make system -C $(PACKAGES_DIR)/harfbuzz
	@make system -C $(PACKAGES_DIR)/pango
	@make system -C $(PACKAGES_DIR)/libsha1
	@make system -C $(PACKAGES_DIR)/xorg/mcookie
	@make system -C $(PACKAGES_DIR)/xorg/server
	@make system -C $(PACKAGES_DIR)/xorg/driver/xf86-input-evdev
	@make system -C $(PACKAGES_DIR)/xorg/driver/xf86-input-libinput
	@make system -C $(PACKAGES_DIR)/xorg/driver/xf86-input-keyboard
	@make system -C $(PACKAGES_DIR)/xorg/driver/xf86-input-mouse
	@make system -C $(PACKAGES_DIR)/xorg/driver/xf86-video-fbdev
	@make system -C $(PACKAGES_DIR)/xorg/app/twm
	@make system -C $(PACKAGES_DIR)/xorg/app/xclock
	@make system -C $(PACKAGES_DIR)/xterm
	@make system -C $(PACKAGES_DIR)/xorg/app/xinit
	@make system -C $(PACKAGES_DIR)/xorg/app/xhost
	@make system -C $(PACKAGES_DIR)/xorg/app/xauth
	@make system -C $(PACKAGES_DIR)/atk
	@make system -C $(PACKAGES_DIR)/at-spi2-core
	@make system -C $(PACKAGES_DIR)/at-spi2-atk
	@make system -C $(PACKAGES_DIR)/gdk-pixbuf
	@make system -C $(PACKAGES_DIR)/libcroco
	@make system -C $(PACKAGES_DIR)/librsvg
	@make system -C $(PACKAGES_DIR)/hicolor-icon-theme
	@make system -C $(PACKAGES_DIR)/adwaita-icon-theme
	@make system -C $(PACKAGES_DIR)/lxde-icon-theme
	@make system -C $(PACKAGES_DIR)/libgtk2
	@make system -C $(PACKAGES_DIR)/libgtk3
	@make system -C $(PACKAGES_DIR)/nanumfont
	@make system -C $(PACKAGES_DIR)/libgpg-error
	@make system -C $(PACKAGES_DIR)/libgcrypt
	@make system -C $(PACKAGES_DIR)/libgudev
	@make system -C $(PACKAGES_DIR)/pcre2
	@make system -C $(PACKAGES_DIR)/sqlite
	@make system -C $(PACKAGES_DIR)/libsoup
	@make system -C $(PACKAGES_DIR)/libsecret
	@make system -C $(PACKAGES_DIR)/enchant
	@make system -C $(PACKAGES_DIR)/gstreamer
	@make system -C $(PACKAGES_DIR)/gst-plugins-base
	@make system -C $(PACKAGES_DIR)/libwebp
	@make system -C $(PACKAGES_DIR)/libtasn1
	@make system -C $(PACKAGES_DIR)/p11-kit
	@make system -C $(PACKAGES_DIR)/gcr
	@make system -C $(PACKAGES_DIR)/gsettings-desktop-schemas
	@make system -C $(PACKAGES_DIR)/iso-codes
	@make system -C $(PACKAGES_DIR)/gnome-desktop
	@make system -C $(PACKAGES_DIR)/json-glib
	@make system -C $(PACKAGES_DIR)/libnotify
	@make system -C $(PACKAGES_DIR)/nspr
	@make system -C $(PACKAGES_DIR)/nss
	@make system -C $(PACKAGES_DIR)/openbox
	@make system -C $(PACKAGES_DIR)/imlib2
	@make system -C $(PACKAGES_DIR)/libstartup-notification
	@make system -C $(PACKAGES_DIR)/tint2
	# @make system -C $(PACKAGES_DIR)/gmp
	# @make system -C $(PACKAGES_DIR)/nettle
	# @make system -C $(PACKAGES_DIR)/gnutls
	# @make system -C $(PACKAGES_DIR)/glib-networking
	# @make system -C $(PACKAGES_DIR)/webkitgtk
	# @make system -C $(PACKAGES_DIR)/epiphany
	@make system -C $(PACKAGES_DIR)/lxmenu-data
	@make system-extra -C $(PACKAGES_DIR)/libfm
	@make system -C $(PACKAGES_DIR)/menu-cache
	@make system -C $(PACKAGES_DIR)/libfm
	@make system -C $(PACKAGES_DIR)/pcmanfm
	@make system -C $(PACKAGES_DIR)/openjpeg
	@make system -C $(PACKAGES_DIR)/poppler
	@make system -C $(PACKAGES_DIR)/epdfview
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
	@qemu-system-arm -M vexpress-a9 -smp 1 -m 1G -kernel $(KERNEL_DIR)/zImage -dtb $(KERNEL_DIR)/vexpress-v2p-ca9.dtb -drive file=$(IMAGES_DIR)/rootfs.ext2,if=sd,format=raw -append "init=/sbin/init console=ttyAMA0,115200 root=/dev/mmcblk0 ip=dhcp" -serial stdio -net user -show-cursor

flash:
	@chmod 755 $(DEVICE_DIR)/raspberrypi/image-usb-stick
	@sudo $(DEVICE_DIR)/raspberrypi/image-usb-stick $(IMAGES_DIR)/sdcard.img
	@sudo -k
	$(PRINT_BUILD_TIME)

clean:
	@rm -rf .config.mk $(OUTPUT_DIR)
