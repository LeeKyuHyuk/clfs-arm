include $(SUPPORT_DIR)/functions.mk

NAME := scons
HOST_DEPENDENCIES := python2
SOURCE := $(SOURCES_DIR)/scons-2.5.1.tar.gz
SOURCE_URL := https://downloads.sourceforge.net/project/scons/scons/2.5.1/scons-2.5.1.tar.gz
MD5 := aaaf09e1351a598f98d17b0cf1103e7a

toolchain:
	@$(STEP) "scons 2.5.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/scons-2.5.1 && $(TOOLS_DIR)/bin/python2 setup.py build )
	@( cd $(BUILD_DIR)/scons-2.5.1 && $(TOOLS_DIR)/bin/python2 setup.py install --prefix=$(TOOLS_DIR) --install-lib=$(TOOLS_DIR)/lib/scons-2.5.1 )
	@rm -rf $(BUILD_DIR)/scons-2.5.1
	@echo $(NAME) >> $(TOOLCHAIN_DEPENDENCIES)
