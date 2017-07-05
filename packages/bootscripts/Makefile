include $(SUPPORT_DIR)/functions.mk

SOURCE := $(PACKAGES_DIR)/bootscripts/lfs-bootscripts-20170325.tar.bz2
SOURCE_URL := http://www.linuxfromscratch.org/lfs/downloads/development/lfs-bootscripts-20170325.tar.bz2
MD5 := b056867b5ada781e79b6fc8c2cfd9ec3

system:
	@$(STEP) "Setting Up System Bootscripts"
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@make DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/lfs-bootscripts-20170325
	@rm -rf $(BUILD_DIR)/lfs-bootscripts-20170325
	@if [ "$(CONFIG_NAME)" = "raspberrypi2" ] || [ "$(CONFIG_NAME)" = "raspberrypi3" ] ; then \
		$(STEP) "Setting Up System PiLFS Bootscripts" ; \
		$(EXTRACT) $(PACKAGES_DIR)/bootscripts/pilfs-bootscripts-20170225.tar.xz $(BUILD_DIR) ; \
		make DESTDIR=$(ROOTFS_DIR) install-everything -C $(BUILD_DIR)/pilfs-bootscripts-20170225 ; \
		rm -rf $(BUILD_DIR)/pilfs-bootscripts-20170225 ; \
	fi;
