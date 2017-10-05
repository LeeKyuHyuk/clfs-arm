include $(SUPPORT_DIR)/functions.mk

NAME := xlib
HOST_DEPENDENCIES := fontconfig libxcb
TARGET_DEPENDENCIES := fontconfig libxcb

toolchain:
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/xtrans
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libX11
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libXext
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libFS
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libICE
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libSM
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libXScrnSaver
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libXt
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libXmu
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libXpm
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libXaw
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libXfixes
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libXcomposite
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libXrender
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libXcursor
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libXdamage
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libfontenc
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libXfont2
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libXft
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libXi
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libXinerama
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libXrandr
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libXres
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libXtst
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libXv
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libXvMC
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libXxf86dga
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libXxf86vm
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libdmx
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libpciaccess
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libxkbfile
	@make toolchain -C $(PACKAGES_DIR)/xorg/lib/libxshmfence
	@echo $(NAME) >> $(TOOLCHAIN_DEPENDENCIES)

system:
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@make system -C $(PACKAGES_DIR)/xorg/lib/xtrans
	@make system -C $(PACKAGES_DIR)/xorg/lib/libX11
	@make system -C $(PACKAGES_DIR)/xorg/lib/libXext
	@make system -C $(PACKAGES_DIR)/xorg/lib/libFS
	@make system -C $(PACKAGES_DIR)/xorg/lib/libICE
	@make system -C $(PACKAGES_DIR)/xorg/lib/libSM
	@make system -C $(PACKAGES_DIR)/xorg/lib/libXScrnSaver
	@make system -C $(PACKAGES_DIR)/xorg/lib/libXt
	@make system -C $(PACKAGES_DIR)/xorg/lib/libXmu
	@make system -C $(PACKAGES_DIR)/xorg/lib/libXpm
	@make system -C $(PACKAGES_DIR)/xorg/lib/libXaw
	@make system -C $(PACKAGES_DIR)/xorg/lib/libXfixes
	@make system -C $(PACKAGES_DIR)/xorg/lib/libXcomposite
	@make system -C $(PACKAGES_DIR)/xorg/lib/libXrender
	@make system -C $(PACKAGES_DIR)/xorg/lib/libXcursor
	@make system -C $(PACKAGES_DIR)/xorg/lib/libXdamage
	@make system -C $(PACKAGES_DIR)/xorg/lib/libfontenc
	@make system -C $(PACKAGES_DIR)/xorg/lib/libXfont2
	@make system -C $(PACKAGES_DIR)/xorg/lib/libXft
	@make system -C $(PACKAGES_DIR)/xorg/lib/libXi
	@make system -C $(PACKAGES_DIR)/xorg/lib/libXinerama
	@make system -C $(PACKAGES_DIR)/xorg/lib/libXrandr
	@make system -C $(PACKAGES_DIR)/xorg/lib/libXres
	@make system -C $(PACKAGES_DIR)/xorg/lib/libXtst
	@make system -C $(PACKAGES_DIR)/xorg/lib/libXv
	@make system -C $(PACKAGES_DIR)/xorg/lib/libXvMC
	@make system -C $(PACKAGES_DIR)/xorg/lib/libXxf86dga
	@make system -C $(PACKAGES_DIR)/xorg/lib/libXxf86vm
	@make system -C $(PACKAGES_DIR)/xorg/lib/libdmx
	@make system -C $(PACKAGES_DIR)/xorg/lib/libpciaccess
	@make system -C $(PACKAGES_DIR)/xorg/lib/libxkbfile
	@make system -C $(PACKAGES_DIR)/xorg/lib/libxshmfence
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
