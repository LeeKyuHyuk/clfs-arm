include $(SUPPORT_DIR)/functions.mk

system:
	@$(STEP) "Install NanumGothic"
	@mkdir -pv $(ROOTFS_DIR)/usr/share/fonts/
	@cp -v $(PACKAGES_DIR)/nanumfont/*.ttf $(ROOTFS_DIR)/usr/share/fonts/
	@echo "font_name = \"NanumGothic\"" >> $(ROOTFS_DIR)/etc/gtk-2.0/gtkrc
