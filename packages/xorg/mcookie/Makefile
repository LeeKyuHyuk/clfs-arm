include $(SUPPORT_DIR)/functions.mk

SOURCE := $(PACKAGES_DIR)/xorg/mcookie/mcookie.c

system:
	@$(STEP) "mcookie"
	@gcc -O2 -I$(TOOLS_DIR)/include $(SOURCE) -o $(TOOLS_DIR)/bin/makedevs -L$(TOOLS_DIR)/lib -L$(TOOLS_DIR)/lib -Wl,-rpath,$(TOOLS_DIR)/lib
	@$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc -Wall -Os -s $(SOURCE) -o  $(ROOTFS_DIR)/usr/bin/mcookie
	@chmod -v 0755 $(ROOTFS_DIR)/usr/bin/mcookie
