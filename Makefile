include settings.mk

START_BUILD_TIME := $(shell date +%s)
define PRINT_BUILD_TIME
@time_end=`date +%s` ; time_exec=`awk -v "TS=${START_BUILD_TIME}" -v "TE=$$time_end" 'BEGIN{TD=TE-TS;printf "%02dh:%02dm:%02ds\n",TD/(60*60)%24,TD/(60)%60,TD%60}'` ; $(STEP) "'$@' Build Time: $${time_exec}"
endef

START_TOTAL_BUILD_TIME := $(shell date +%s)
define PRINT_TOTAL_BUILD_TIME
@time_end=`date +%s` ; time_exec=`awk -v "TS=${START_TOTAL_BUILD_TIME}" -v "TE=$$time_end" 'BEGIN{TD=TE-TS;printf "%02dh:%02dm:%02ds\n",TD/(60*60)%24,TD/(60)%60,TD%60}'` ; $(STEP) "Total Build Time: $${time_exec}"
endef


help:
	@echo
	@echo -e '  \e[7mBuild\e[0m'
	@echo -e '    \e[1mall\e[0m                    - Build CLFS-ARM with toolchain'
	@echo -e '    \e[1mtoolchain\e[0m              - Build toolchain'
	@echo -e '    \e[1msystem\e[0m                 - Build CLFS-ARM root file system'
	@echo -e '    \e[1mkernel\e[0m                 - Build kernel'
	@echo -e '    \e[1mimage\e[0m                  - Generate root file system image'
	@echo
	@echo -e '  \e[7mCleaning\e[0m'
	@echo -e '    \e[1mclean\e[0m                  - Delete all files created by build'
	@echo
	@echo -e '  \e[7mMiscellaneous\e[0m'
	@echo -e '    \e[1mrun\e[0m                    - Emulate CLFS-ARM using QEMU'
	@echo -e '    \e[1msetting\e[0m                - Show build settings'
	@echo

all:
	@make settings
	@make toolchain
	@make system
	@make kernel
	@make image
	$(PRINT_TOTAL_BUILD_TIME)

check:
	@if ! [[ -d $(SOURCES_DIR) ]] ; then \
	    $(ERROR) "Can't find sources directory!" ; \
			$(ERROR) "Run 'make download'." ; \
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
	@if ! [[ -d $(SOURCES_DIR) ]] ; then \
	    $(ERROR) "Can't find sources directory!" ; \
			$(ERROR) "Run 'make download'." ; \
			exit 1 ; \
	fi;
	@$(STEP) "Create toolchain directory."
	@rm -rf $(BUILD_DIR) $(TOOLS_DIR)
	@mkdir -pv $(BUILD_DIR) $(TOOLS_DIR)
	@$(SCRIPTS_DIR)/toolchain.sh
	@make toolchain-staging
	$(PRINT_BUILD_TIME)

toolchain-staging:
	@make check
	@rm -rf $(BUILD_DIR)
	@mkdir -pv $(BUILD_DIR)
	@$(SCRIPTS_DIR)/toolchain-staging.sh
	$(PRINT_BUILD_TIME)

system:
	@make check
	@rm -rf $(BUILD_DIR) $(ROOTFS_DIR)
	@mkdir -pv $(BUILD_DIR) $(ROOTFS_DIR)
	@$(SCRIPTS_DIR)/create_rootfs.sh
	@$(SCRIPTS_DIR)/system.sh
	$(PRINT_BUILD_TIME)

kernel:
	@make check
	@rm -rf $(BUILD_DIR) $(KERNEL_DIR)
	@mkdir -pv $(BUILD_DIR) $(KERNEL_DIR)
	@$(SCRIPTS_DIR)/kernel.sh

image:
	@make check
	@rm -rf $(BUILD_DIR) $(IMAGES_DIR)
	@mkdir -pv $(BUILD_DIR) $(IMAGES_DIR)
	@$(SCRIPTS_DIR)/image.sh

settings:
	@$(SCRIPTS_DIR)/settings.sh

run:
	@qemu-system-arm -M vexpress-a9 -smp 1 -m 256 -kernel $(KERNEL_DIR)/zImage -dtb $(KERNEL_DIR)/vexpress-v2p-ca9.dtb -drive file=$(IMAGES_DIR)/rootfs.ext2,if=sd,format=raw -append "console=ttyAMA0,115200 root=/dev/mmcblk0 ip=dhcp" -serial stdio -net nic,model=lan9118 -net user -redir tcp:10022::22 -redir tcp:10080::80

clean:
	@rm -rf $(SOURCES_DIR) $(OUTPUT_DIR)
