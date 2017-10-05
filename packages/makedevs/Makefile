include $(SUPPORT_DIR)/functions.mk

NAME := makedevs
SOURCE := $(PACKAGES_DIR)/makedevs/makedevs.c

toolchain:
	@$(STEP) "makedevs"
	@gcc -O2 -I$(TOOLS_DIR)/include $(SOURCE) -o $(TOOLS_DIR)/bin/makedevs -L$(TOOLS_DIR)/lib -L$(TOOLS_DIR)/lib -Wl,-rpath,$(TOOLS_DIR)/lib
	@chmod 755 $(TOOLS_DIR)/bin/makedevs
	@echo $(NAME) >> $(TOOLCHAIN_DEPENDENCIES)
