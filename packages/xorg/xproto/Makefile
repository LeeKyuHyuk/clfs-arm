include $(SUPPORT_DIR)/functions.mk

SOURCE := bigreqsproto-1.1.2 compositeproto-0.4.2 damageproto-1.2.1 dmxproto-2.3.1 dri2proto-2.8 dri3proto-1.0 fixesproto-5.0 fontsproto-2.1.3 glproto-1.4.17 inputproto-2.3.2 kbproto-1.0.7 presentproto-1.1 randrproto-1.5.0 recordproto-1.14.2 renderproto-0.11.1 resourceproto-1.2.0 scrnsaverproto-1.2.2 videoproto-2.3.3 xcmiscproto-1.2.2 xextproto-7.3.0 xf86bigfontproto-1.2.0 xf86dgaproto-2.1 xf86driproto-2.1.1 xf86vidmodeproto-2.3.1 xineramaproto-1.2.1 xproto-7.0.31

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@for xproto in $(SOURCE) ; do \
		$(EXTRACT) $(PACKAGES_DIR)/xorg/xproto/$${xproto}.tar.bz2 $(BUILD_DIR) ; \
		( cd $(BUILD_DIR)/$${xproto} && \
		./configure \
		--target=$(CONFIG_TARGET) \
		--host=$(CONFIG_TARGET) \
		--build=$(CONFIG_HOST) \
	 	--prefix=$(SYSROOT_DIR)/usr \
		--sysconfdir=$(SYSROOT_DIR)/etc \
		--localstatedir=$(SYSROOT_DIR)/var \
		--disable-static ) || exit 1; \
		make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/$${xproto} || exit 1; \
		make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/$${xproto} || exit 1; \
		rm -rf $(BUILD_DIR)/$${xproto} ; \
	done

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@for xproto in $(SOURCE) ; do \
		$(EXTRACT) $(PACKAGES_DIR)/xorg/xproto/$${xproto}.tar.bz2 $(BUILD_DIR) ; \
		( cd $(BUILD_DIR)/$${xproto} && \
		./configure \
		--target=$(CONFIG_TARGET) \
		--host=$(CONFIG_TARGET) \
		--build=$(CONFIG_HOST) \
	 	--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--disable-static ) || exit 1; \
		make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/$${xproto} || exit 1; \
		make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/$${xproto} || exit 1; \
		rm -rf $(BUILD_DIR)/$${xproto} ; \
	done
