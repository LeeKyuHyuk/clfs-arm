include $(SUPPORT_DIR)/functions.mk

SOURCE := $(PACKAGES_DIR)/mkpasswd

toolchain:
	@$(STEP) "mkpasswd 5.0.26"
	@gcc -O2 -I$(TOOLS_DIR)/include -L$(TOOLS_DIR)/lib -L$(TOOLS_DIR)/lib -Wl,-rpath,$(TOOLS_DIR)/lib $(SOURCE)/mkpasswd.c $(SOURCE)/utils.c -o $(TOOLS_DIR)/bin/mkpasswd -lcrypt
	@chmod 755 $(TOOLS_DIR)/bin/mkpasswd
