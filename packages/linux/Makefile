include $(SUPPORT_DIR)/functions.mk

NAME := linux-headers

staging:
	@$(STEP) "Linux API Headers"
	@$(call check_source, $(SOURCES_DIR)/$(CONFIG_LINUX_KERNEL_SOURCE), $(CONFIG_LINUX_KERNEL_SOURCE_MD5), $(CONFIG_LINUX_KERNEL_SOURCE_URL))
	@mkdir -p $(BUILD_DIR)/linux-header
	@tar -xzf $(SOURCES_DIR)/$(CONFIG_LINUX_KERNEL_SOURCE) --strip-components=1 -C $(BUILD_DIR)/linux-header
	@make mrproper -C $(BUILD_DIR)/linux-header
	@make -j$(CONFIG_PARALLEL_JOBS) ARCH=$(CONFIG_MODE) headers_check -C $(BUILD_DIR)/linux-header
	@make -j$(CONFIG_PARALLEL_JOBS) ARCH=$(CONFIG_MODE) INSTALL_HDR_PATH=$(SYSROOT_DIR)/usr headers_install -C $(BUILD_DIR)/linux-header
	@rm -rf $(BUILD_DIR)/linux-header

system:
	@$(STEP) "Linux API Headers"
	@$(call check_source, $(SOURCES_DIR)/$(CONFIG_LINUX_KERNEL_SOURCE), $(CONFIG_LINUX_KERNEL_SOURCE_MD5), $(CONFIG_LINUX_KERNEL_SOURCE_URL))
	@mkdir -p $(BUILD_DIR)/linux-header/dest
	@tar -xzf $(SOURCES_DIR)/$(CONFIG_LINUX_KERNEL_SOURCE) --strip-components=1 -C $(BUILD_DIR)/linux-header
	@make mrproper -C $(BUILD_DIR)/linux-header
	@make -j$(CONFIG_PARALLEL_JOBS) ARCH=$(CONFIG_MODE) headers_check -C $(BUILD_DIR)/linux-header
	@make -j$(CONFIG_PARALLEL_JOBS) ARCH=$(CONFIG_MODE) INSTALL_HDR_PATH=$(BUILD_DIR)/linux-header/dest headers_install -C $(BUILD_DIR)/linux-header
	@find $(BUILD_DIR)/linux-header/dest/include \( -name .install -o -name ..install.cmd \) -delete
	@mkdir -pv $(ROOTFS_DIR)/usr/include
	@cp -rv $(BUILD_DIR)/linux-header/dest/include/* $(ROOTFS_DIR)/usr/include
	@rm -rf $(BUILD_DIR)/linux-header

kernel:
	@$(STEP) "Linux Kernel"
	@$(call check_source, $(SOURCES_DIR)/$(CONFIG_LINUX_KERNEL_SOURCE), $(CONFIG_LINUX_KERNEL_SOURCE_MD5), $(CONFIG_LINUX_KERNEL_SOURCE_URL))
	@mkdir -p $(BUILD_DIR)/linux-kernel
	@tar -xzf $(SOURCES_DIR)/$(CONFIG_LINUX_KERNEL_SOURCE) --strip-components=1 -C $(BUILD_DIR)/linux-kernel
	@make mrproper -C $(BUILD_DIR)/linux-kernel
	@make -j$(CONFIG_PARALLEL_JOBS) ARCH=$(CONFIG_MODE) headers_check -C $(BUILD_DIR)/linux-kernel
	@make -j$(CONFIG_PARALLEL_JOBS) ARCH=$(CONFIG_MODE) CROSS_COMPILE="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-" $(CONFIG_LINUX_KERNEL_DEFCONFIG)_defconfig -C $(BUILD_DIR)/linux-kernel
	@sed -i -e "/\\<CONFIG_KERNEL_GZIP\\>/d" $(BUILD_DIR)/linux-kernel/.config
	@echo 'CONFIG_KERNEL_GZIP=y' >> $(BUILD_DIR)/linux-kernel/.config
	@sed -i -e "/\\<CONFIG_KERNEL_XZ\\>/d" $(BUILD_DIR)/linux-kernel/.config
	@echo '# CONFIG_KERNEL_XZ is not set' >> $(BUILD_DIR)/linux-kernel/.config
	@sed -i -e "/\\<CONFIG_CPU_LITTLE_ENDIAN\\>/d" $(BUILD_DIR)/linux-kernel/.config
	@echo 'CONFIG_CPU_LITTLE_ENDIAN=y' >> $(BUILD_DIR)/linux-kernel/.config
	@sed -i -e "/\\<CONFIG_AEABI\\>/d" $(BUILD_DIR)/linux-kernel/.config
	@echo 'CONFIG_AEABI=y' >> $(BUILD_DIR)/linux-kernel/.config
	@sed -i -e "/\\<CONFIG_DEVTMPFS\\>/d" $(BUILD_DIR)/linux-kernel/.config
	@echo 'CONFIG_DEVTMPFS=y' >> $(BUILD_DIR)/linux-kernel/.config
	@sed -i -e "/\\<CONFIG_DEVTMPFS_MOUNT\\>/d" $(BUILD_DIR)/linux-kernel/.config
	@echo 'CONFIG_DEVTMPFS_MOUNT=y' >> $(BUILD_DIR)/linux-kernel/.config
	@sed -i -e "/\\<CONFIG_INOTIFY_USER\\>/d" $(BUILD_DIR)/linux-kernel/.config
	@echo 'CONFIG_INOTIFY_USER=y' >> $(BUILD_DIR)/linux-kernel/.config
	@make -j$(CONFIG_PARALLEL_JOBS) ARCH=$(CONFIG_MODE) CROSS_COMPILE="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-" zImage modules -C $(BUILD_DIR)/linux-kernel
	@for dtb in $(CONFIG_LINUX_KERNEL_INTREE_DTS_NAME) ; do \
		make -j$(CONFIG_PARALLEL_JOBS) ARCH=$(CONFIG_MODE) CROSS_COMPILE="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-" $${dtb}.dtb -C $(BUILD_DIR)/linux-kernel ; \
	done
	@if grep -q "CONFIG_MODULES=y" $(BUILD_DIR)/linux-kernel/.config; then \
		make -j1 ARCH=$(CONFIG_MODE) CROSS_COMPILE="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-" INSTALL_MOD_PATH=$(ROOTFS_DIR) INSTALL_MOD_STRIP=1 -C $(BUILD_DIR)/linux-kernel modules_install ; \
		rm -f $(ROOTFS_DIR)/lib/modules/`make -j$(CONFIG_PARALLEL_JOBS) ARCH=$(CONFIG_MODE) CROSS_COMPILE="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-" INSTALL_MOD_PATH=$(ROOTFS_DIR) INSTALL_MOD_STRIP=1 -C $(BUILD_DIR)/linux-kernel --no-print-directory -s kernelrelease 2>/dev/null`/build ; \
		rm -f $(ROOTFS_DIR)/lib/modules/`make -j$(CONFIG_PARALLEL_JOBS) ARCH=$(CONFIG_MODE) CROSS_COMPILE="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-" INSTALL_MOD_PATH=$(ROOTFS_DIR) INSTALL_MOD_STRIP=1 -C $(BUILD_DIR)/linux-kernel --no-print-directory -s kernelrelease 2>/dev/null`/source ; \
	fi
	@if grep -q "CONFIG_DTC=y" $(BUILD_DIR)/linux-kernel/.config; then 	\
		install -Dv -m 0755 $(BUILD_DIR)/linux-kernel/scripts/dtc/dtc $(TOOLS_DIR)/bin/linux-dtc ;	\
		if [ ! -e $(TOOLS_DIR)/bin/dtc ]; then	\
			ln -sf linux-dtc $(TOOLS_DIR)/bin/dtc ;	\
		fi	\
	fi
	@install -m 0644 -Dv $(BUILD_DIR)/linux-kernel/arch/arm/boot/zImage $(KERNEL_DIR)/zImage
	@for dtb in $(CONFIG_LINUX_KERNEL_INTREE_DTS_NAME) ; do \
		cp -v $(BUILD_DIR)/linux-kernel/arch/arm/boot/dts/$${dtb}.dtb $(KERNEL_DIR) ; \
	done
	@rm -rf $(BUILD_DIR)/linux-kernel
