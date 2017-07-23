include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/xorg-server-1.19.3.tar.bz2
SOURCE_URL := https://www.x.org/pub/individual/xserver/xorg-server-1.19.3.tar.bz2
MD5 := 015d2fc4b9f2bfe7a626edb63a62c65e

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "xorg server 1.19.3"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/xorg/xserver/xorg-server-1.19.3-add_prime_support-1.patch -d $(BUILD_DIR)/xorg-server-1.19.3
	@patch -Np1 -i $(PACKAGES_DIR)/xorg/xserver/configure.ac-Fix-check-for-CLOCK_MONOTONIC.patch -d $(BUILD_DIR)/xorg-server-1.19.3
	@patch -Np1 -i $(PACKAGES_DIR)/xorg/xserver/configure.ac-Fix-wayland-scanner-and-protocols-locat.patch -d $(BUILD_DIR)/xorg-server-1.19.3
	@( cd $(BUILD_DIR)/xorg-server-1.19.3 && autoconf )
	@( cd $(BUILD_DIR)/xorg-server-1.19.3 && \
	PKG_CONFIG="$(TOOLS_DIR)/usr/bin/pkg-config" \
	ACLOCAL="aclocal -I $(SYSROOT_DIR)/usr/share/aclocal" \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--libdir=/usr/lib \
	--sysconfdir=/etc \
	--disable-static \
	--enable-malloc0returnsnull \
	--disable-docs \
	--disable-devel-docs \
	--enable-xwayland \
	--enable-xorg \
	--disable-xvfb \
	--disable-xnest \
	--disable-xquartz \
	--disable-xwin )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/xorg-server-1.19.3
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/xorg-server-1.19.3
	@install -c -m 644 $(BUILD_DIR)/xorg-server-1.19.3/xorg-server.m4 $(SYSROOT_DIR)/usr/share/aclocal
	@install -c -m 644 $(BUILD_DIR)/xorg-server-1.19.3/xorg-server.pc $(SYSROOT_DIR)/usr/lib/pkgconfig
	@rm -rf $(BUILD_DIR)/xorg-server-1.19.3

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "xorg server 1.19.3"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/xorg/xserver/xorg-server-1.19.3-add_prime_support-1.patch -d $(BUILD_DIR)/xorg-server-1.19.3
	@patch -Np1 -i $(PACKAGES_DIR)/xorg/xserver/configure.ac-Fix-check-for-CLOCK_MONOTONIC.patch -d $(BUILD_DIR)/xorg-server-1.19.3
	@patch -Np1 -i $(PACKAGES_DIR)/xorg/xserver/configure.ac-Fix-wayland-scanner-and-protocols-locat.patch -d $(BUILD_DIR)/xorg-server-1.19.3
	@( cd $(BUILD_DIR)/xorg-server-1.19.3 && autoconf )
	@( cd $(BUILD_DIR)/xorg-server-1.19.3 && \
	PKG_CONFIG="$(TOOLS_DIR)/usr/bin/pkg-config" \
	ACLOCAL="aclocal -I $(ROOTFS_DIR)/usr/share/aclocal" \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--libdir=/usr/lib \
	--sysconfdir=/etc \
	--disable-static \
	--enable-malloc0returnsnull \
	--disable-docs \
	--disable-devel-docs \
	--enable-xwayland \
	--enable-xorg \
	--disable-xvfb \
	--disable-xnest \
	--disable-xquartz \
	--disable-xwin )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/xorg-server-1.19.3
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/xorg-server-1.19.3
	@install -c -m 644 $(BUILD_DIR)/xorg-server-1.19.3/xorg-server.m4 $(ROOTFS_DIR)/usr/share/aclocal
	@install -c -m 644 $(BUILD_DIR)/xorg-server-1.19.3/xorg-server.pc $(ROOTFS_DIR)/usr/lib/pkgconfig
	@echo "/tmp/.ICE-unix dir 1777 root root" >> $(ROOTFS_DIR)/etc/sysconfig/createfiles
	@echo "/tmp/.X11-unix dir 1777 root root" >> $(ROOTFS_DIR)/etc/sysconfig/createfiles
	@rm -rf $(BUILD_DIR)/xorg-server-1.19.3
