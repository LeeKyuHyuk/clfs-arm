include $(SUPPORT_DIR)/functions.mk

SOURCE := font-util-1.3.1 encodings-1.0.4 font-alias-1.0.3 font-adobe-utopia-type1-1.0.4 font-bh-ttf-1.0.3 font-bh-type1-1.0.3 font-ibm-type1-1.0.3 font-misc-ethiopic-1.0.3 font-xfree86-type1-1.0.4

toolchain:
	@for xfonts in $(SOURCE) ; do \
		$(EXTRACT) $(PACKAGES_DIR)/xorg/xfonts/$${xfonts}.tar.bz2 $(BUILD_DIR) ; \
		( cd $(BUILD_DIR)/$${xfonts} && \
		CFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
		CPPFLAGS="-I$(TOOLS_DIR)/usr/include" \
		CXXFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
		LDFLAGS="-L$(TOOLS_DIR)/lib -L$(TOOLS_DIR)/usr/lib -Wl,-rpath,$(TOOLS_DIR)/usr/lib" \
		PKG_CONFIG="$(TOOLS_DIR)/usr/bin/pkg-config" \
		PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/usr/lib/pkgconfig:$(TOOLS_DIR)/usr/share/pkgconfig" \
		PKG_CONFIG_SYSROOT_DIR="/" \
		PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
		PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
		./configure \
		--prefix=$(TOOLS_DIR)/usr \
		--sysconfdir=$(TOOLS_DIR)/etc \
		--localstatedir=$(TOOLS_DIR)/var \
		--disable-static ) || exit 1; \
		make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/$${xfonts} || exit 1; \
		make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/$${xfonts} || exit 1; \
		rm -rf $(BUILD_DIR)/$${xfonts} ; \
	done

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@for xfonts in $(SOURCE) ; do \
		$(EXTRACT) $(PACKAGES_DIR)/xorg/xfonts/$${xfonts}.tar.bz2 $(BUILD_DIR) ; \
		( cd $(BUILD_DIR)/$${xfonts} && \
		./configure \
		--target=$(CONFIG_TARGET) \
		--host=$(CONFIG_TARGET) \
		--build=$(CONFIG_HOST) \
	 	--prefix=$(SYSROOT_DIR)/usr \
		--sysconfdir=$(SYSROOT_DIR)/etc \
		--localstatedir=$(SYSROOT_DIR)/var \
		--disable-static ) || exit 1; \
		make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/$${xfonts} || exit 1; \
		make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/$${xfonts} || exit 1; \
		rm -rf $(BUILD_DIR)/$${xfonts} ; \
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
	@for xfonts in $(SOURCE) ; do \
		$(EXTRACT) $(PACKAGES_DIR)/xorg/xfonts/$${xfonts}.tar.bz2 $(BUILD_DIR) ; \
		( cd $(BUILD_DIR)/$${xfonts} && \
		./configure \
		--target=$(CONFIG_TARGET) \
		--host=$(CONFIG_TARGET) \
		--build=$(CONFIG_HOST) \
	 	--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--disable-static ) || exit 1; \
		make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/$${xfonts} || exit 1; \
		make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/$${xfonts} || exit 1; \
		rm -rf $(BUILD_DIR)/$${xfonts} ; \
	done
	@install -v -d -m755 $(ROOTFS_DIR)/usr/share/fonts
	@ln -svfn $(ROOTFS_DIR)/usr/share/fonts/X11/OTF $(ROOTFS_DIR)/usr/share/fonts/X11-OTF
	@ln -svfn $(ROOTFS_DIR)/usr/share/fonts/X11/TTF $(ROOTFS_DIR)/usr/share/fonts/X11-TTF
