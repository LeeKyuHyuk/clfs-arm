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
	@make toolchain -C $(SUPPORT_DIR)/systemd # Essential Toolchain Package
	$(PRINT_BUILD_TIME)

system:
	@make system -C $(SUPPORT_DIR)/systemd # Essential System Package
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
	@qemu-system-arm -M vexpress-a9 -smp 1 -m 256 -kernel $(KERNEL_DIR)/zImage -dtb $(KERNEL_DIR)/vexpress-v2p-ca9.dtb -drive file=$(IMAGES_DIR)/rootfs.ext2,if=sd,format=raw -append "init=/sbin/init console=ttyAMA0,115200 root=/dev/mmcblk0 ip=dhcp" -serial stdio -net nic,model=lan9118 -net user -show-cursor

flash:
	@chmod 755 $(DEVICE_DIR)/raspberrypi/image-usb-stick
	@sudo $(DEVICE_DIR)/raspberrypi/image-usb-stick $(IMAGES_DIR)/sdcard.img
	@sudo -k
	$(PRINT_BUILD_TIME)

clean:
	@rm -rf .config.mk $(OUTPUT_DIR)
