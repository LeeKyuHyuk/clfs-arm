include $(SUPPORT_DIR)/functions.mk

NAME := nanumfont

system:
	@$(STEP) "Install NanumGothic"
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@mkdir -pv $(ROOTFS_DIR)/usr/share/fonts/
	@cp -v $(PACKAGES_DIR)/nanumfont/*.ttf $(ROOTFS_DIR)/usr/share/fonts/
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
