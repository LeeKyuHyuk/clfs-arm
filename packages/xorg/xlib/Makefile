include $(SUPPORT_DIR)/functions.mk

SOURCE := xtrans-1.3.5 libX11-1.6.5 libXext-1.3.3 libFS-1.0.7 libICE-1.0.9 libSM-1.2.2 libXScrnSaver-1.2.2 libXt-1.1.5 libXmu-1.1.2 libXpm-3.5.12 libXaw-1.0.13 libXfixes-5.0.3 libXcomposite-0.4.4 libXrender-0.9.10 libXcursor-1.1.14 libXdamage-1.1.4 libfontenc-1.1.3 libXfont2-2.0.1 libXft-2.3.2 libXi-1.7.9 libXinerama-1.1.3 libXrandr-1.5.1 libXres-1.0.7 libXtst-1.2.3 libXv-1.0.11 libXvMC-1.0.10 libXxf86dga-1.1.4 libXxf86vm-1.1.4 libdmx-1.1.3 libpciaccess-0.13.5 libxkbfile-1.0.9 libxshmfence-1.2

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@for xlib in $(SOURCE) ; do \
		$(EXTRACT) $(PACKAGES_DIR)/xorg/xlib/$${xlib}.tar.bz2 $(BUILD_DIR) ; \
		case $${xlib} in \
			libICE* ) \
				( cd $(BUILD_DIR)/$${xlib} && \
				./configure \
				--target=$(CONFIG_TARGET) \
				--host=$(CONFIG_TARGET) \
				--build=$(CONFIG_HOST) \
				--prefix=$(SYSROOT_DIR)/usr \
				--sysconfdir=$(SYSROOT_DIR)/etc \
				--localstatedir=$(SYSROOT_DIR)/var \
				--disable-static \
				--enable-malloc0returnsnull \
				ICE_LIBS=-lpthread ) || exit 1; \
				;; \
			libXfont2-[0-9]* ) \
				( cd $(BUILD_DIR)/$${xlib} && \
				./configure \
				--target=$(CONFIG_TARGET) \
				--host=$(CONFIG_TARGET) \
				--build=$(CONFIG_HOST) \
				--prefix=$(SYSROOT_DIR)/usr \
				--sysconfdir=$(SYSROOT_DIR)/etc \
				--localstatedir=$(SYSROOT_DIR)/var \
				--disable-static \
				--enable-malloc0returnsnull \
				--disable-devel-docs ) || exit 1; \
			;; \
			libXt-[0-9]* ) \
				( cd $(BUILD_DIR)/$${xlib} && \
				./configure \
				--target=$(CONFIG_TARGET) \
				--host=$(CONFIG_TARGET) \
				--build=$(CONFIG_HOST) \
				--prefix=$(SYSROOT_DIR)/usr \
				--sysconfdir=$(SYSROOT_DIR)/etc \
				--localstatedir=$(SYSROOT_DIR)/var \
				--disable-static \
				--disable-malloc0returnsnull \
				--disable-install-makestrs ) || exit 1; \
			;; \
			* ) \
				( cd $(BUILD_DIR)/$${xlib} && \
				./configure \
				--target=$(CONFIG_TARGET) \
				--host=$(CONFIG_TARGET) \
				--build=$(CONFIG_HOST) \
				--prefix=$(SYSROOT_DIR)/usr \
				--sysconfdir=$(SYSROOT_DIR)/etc \
				--localstatedir=$(SYSROOT_DIR)/var \
				--disable-static \
				--enable-malloc0returnsnull ) || exit 1; \
			;; \
		esac ; \
		make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/$${xlib} || exit 1; \
		make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/$${xlib} || exit 1; \
		rm -rf $(BUILD_DIR)/$${xlib} ; \
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
	@for xlib in $(SOURCE) ; do \
		$(EXTRACT) $(PACKAGES_DIR)/xorg/xlib/$${xlib}.tar.bz2 $(BUILD_DIR) ; \
		case $${xlib} in \
			libICE* ) \
				( cd $(BUILD_DIR)/$${xlib} && \
				./configure \
				--target=$(CONFIG_TARGET) \
				--host=$(CONFIG_TARGET) \
				--build=$(CONFIG_HOST) \
				--prefix=/usr \
				--sysconfdir=/etc \
				--localstatedir=/var \
				--disable-static \
				--enable-malloc0returnsnull \
				ICE_LIBS=-lpthread ) || exit 1; \
				;; \
			libXfont2-[0-9]* ) \
				( cd $(BUILD_DIR)/$${xlib} && \
				./configure \
				--target=$(CONFIG_TARGET) \
				--host=$(CONFIG_TARGET) \
				--build=$(CONFIG_HOST) \
				--prefix=/usr \
				--sysconfdir=/etc \
				--localstatedir=/var \
				--disable-static \
				--enable-malloc0returnsnull \
				--disable-devel-docs ) || exit 1; \
			;; \
			libXt-[0-9]* ) \
				( cd $(BUILD_DIR)/$${xlib} && \
				./configure \
				--target=$(CONFIG_TARGET) \
				--host=$(CONFIG_TARGET) \
				--build=$(CONFIG_HOST) \
				--prefix=/usr \
				--sysconfdir=/etc \
				--localstatedir=/var \
				--disable-static \
				--disable-malloc0returnsnull \
				--disable-install-makestrs ) || exit 1; \
			;; \
			* ) \
				( cd $(BUILD_DIR)/$${xlib} && \
				./configure \
				--target=$(CONFIG_TARGET) \
				--host=$(CONFIG_TARGET) \
				--build=$(CONFIG_HOST) \
				--prefix=/usr \
				--sysconfdir=/etc \
				--localstatedir=/var \
				--disable-static \
				--enable-malloc0returnsnull ) || exit 1; \
			;; \
		esac ; \
		make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/$${xlib} || exit 1; \
		make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/$${xlib} || exit 1; \
		rm -rf $(BUILD_DIR)/$${xlib} ; \
	done
