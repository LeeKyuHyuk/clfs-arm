include $(SUPPORT_DIR)/functions.mk

NAME := zic
SOURCE := $(SOURCES_DIR)/tzcode2017b.tar.gz
SOURCE_URL := https://www.iana.org/time-zones/repository/releases/tzcode2017b.tar.gz
MD5 := afaf15deb13759e8b543d86350385b16

toolchain:
	@$(STEP) "zic 2017b"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@mkdir -p $(BUILD_DIR)/tzcode2017b
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)/tzcode2017b
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/tzcode2017b zic
	@install -Dv -m 755 $(BUILD_DIR)/tzcode2017b/zic $(TOOLS_DIR)/sbin/zic
	@install -Dv -m 644 $(BUILD_DIR)/tzcode2017b/tzfile.h $(TOOLS_DIR)/include/tzfile.h
	@rm -rf $(BUILD_DIR)/tzcode2017b
	@echo $(NAME) >> $(TOOLCHAIN_DEPENDENCIES)
