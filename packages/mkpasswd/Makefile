include $(SUPPORT_DIR)/functions.mk

SOURCE := $(PACKAGES_DIR)/mkpasswd

toolchain:
	@$(STEP) "mkpasswd 5.0.26"
	@gcc -O2 -I$(TOOLS_DIR)/usr/include -L$(TOOLS_DIR)/lib -L$(TOOLS_DIR)/usr/lib -Wl,-rpath,$(TOOLS_DIR)/usr/lib $(SOURCE)/mkpasswd.c $(SOURCE)/utils.c -o $(TOOLS_DIR)/usr/bin/mkpasswd -lcrypt
	@chmod 755 $(TOOLS_DIR)/usr/bin/mkpasswd
