NAME := skeleton

staging:
	@$(STEP) "Create the Sysroot Directory"
	@install -dv -m 0755 $(SYSROOT_DIR)/usr/lib
	@install -dv -m 0755 $(SYSROOT_DIR)/usr/bin
	@install -dv -m 0755 $(SYSROOT_DIR)/usr/sbin
	@install -dv -m 0755 $(SYSROOT_DIR)/usr/include
	@ln -snvf usr/bin $(SYSROOT_DIR)/bin
	@ln -snvf usr/sbin $(SYSROOT_DIR)/sbin
	@ln -snvf usr/lib $(SYSROOT_DIR)/lib
	@ln -snvf lib $(SYSROOT_DIR)/lib32
	@ln -snvf lib $(SYSROOT_DIR)/usr/lib32

system:
	@$(SCRIPTS_DIR)/create_rootfs.sh
