include $(SUPPORT_DIR)/functions.mk

NAME := xproto
HOST_DEPENDENCIES := util-macros
TARGET_DEPENDENCIES := util-macros

toolchain:
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/bigreqsproto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/compositeproto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/damageproto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/dmxproto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/dri2proto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/dri3proto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/fixesproto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/fontsproto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/glproto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/inputproto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/kbproto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/presentproto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/randrproto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/recordproto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/renderproto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/resourceproto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/scrnsaverproto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/videoproto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/xcmiscproto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/xextproto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/xf86bigfontproto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/xf86dgaproto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/xf86driproto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/xf86vidmodeproto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/xineramaproto
	@make toolchain -C $(PACKAGES_DIR)/xorg/proto/xproto
	@echo $(NAME) >> $(TOOLCHAIN_DEPENDENCIES)

system:
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@make system -C $(PACKAGES_DIR)/xorg/proto/bigreqsproto
	@make system -C $(PACKAGES_DIR)/xorg/proto/compositeproto
	@make system -C $(PACKAGES_DIR)/xorg/proto/damageproto
	@make system -C $(PACKAGES_DIR)/xorg/proto/dmxproto
	@make system -C $(PACKAGES_DIR)/xorg/proto/dri2proto
	@make system -C $(PACKAGES_DIR)/xorg/proto/dri3proto
	@make system -C $(PACKAGES_DIR)/xorg/proto/fixesproto
	@make system -C $(PACKAGES_DIR)/xorg/proto/fontsproto
	@make system -C $(PACKAGES_DIR)/xorg/proto/glproto
	@make system -C $(PACKAGES_DIR)/xorg/proto/inputproto
	@make system -C $(PACKAGES_DIR)/xorg/proto/kbproto
	@make system -C $(PACKAGES_DIR)/xorg/proto/presentproto
	@make system -C $(PACKAGES_DIR)/xorg/proto/randrproto
	@make system -C $(PACKAGES_DIR)/xorg/proto/recordproto
	@make system -C $(PACKAGES_DIR)/xorg/proto/renderproto
	@make system -C $(PACKAGES_DIR)/xorg/proto/resourceproto
	@make system -C $(PACKAGES_DIR)/xorg/proto/scrnsaverproto
	@make system -C $(PACKAGES_DIR)/xorg/proto/videoproto
	@make system -C $(PACKAGES_DIR)/xorg/proto/xcmiscproto
	@make system -C $(PACKAGES_DIR)/xorg/proto/xextproto
	@make system -C $(PACKAGES_DIR)/xorg/proto/xf86bigfontproto
	@make system -C $(PACKAGES_DIR)/xorg/proto/xf86dgaproto
	@make system -C $(PACKAGES_DIR)/xorg/proto/xf86driproto
	@make system -C $(PACKAGES_DIR)/xorg/proto/xf86vidmodeproto
	@make system -C $(PACKAGES_DIR)/xorg/proto/xineramaproto
	@make system -C $(PACKAGES_DIR)/xorg/proto/xproto
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
