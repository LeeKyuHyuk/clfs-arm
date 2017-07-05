include $(SUPPORT_DIR)/functions.mk

SOURCE := $(PACKAGES_DIR)/makedevs/makedevs.c

toolchain:
	@$(STEP) "makedevs"
	@gcc -O2 -I$(TOOLS_DIR)/usr/include $(SOURCE) -o $(TOOLS_DIR)/usr/bin/makedevs -L$(TOOLS_DIR)/lib -L$(TOOLS_DIR)/usr/lib -Wl,-rpath,$(TOOLS_DIR)/usr/lib
	@chmod 755 $(TOOLS_DIR)/usr/bin/makedevs
