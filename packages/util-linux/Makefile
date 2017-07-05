include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/util-linux-2.29.2.tar.xz
SOURCE_URL := https://www.kernel.org/pub/linux/utils/util-linux/v2.29/util-linux-2.29.2.tar.xz
MD5 := 63c40c2068fcbb7e1d5c1d281115d973

toolchain:
	@$(STEP) "util-linux 2.29.2"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/util-linux-2.29.2 && \
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
	--enable-shared \
	--disable-static \
	--without-python \
	--enable-libblkid \
	--enable-libmount \
	--enable-libuuid \
	--without-ncurses \
	--without-tinfo \
	--disable-all-programs )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/util-linux-2.29.2
	@make -j$(CONFIG_PARALLEL_JOBS) install MKINSTALLDIRS=$(BUILD_DIR)/util-linux-2.29.2/config/mkinstalldirs -C $(BUILD_DIR)/util-linux-2.29.2
	@rm -rf $(BUILD_DIR)/util-linux-2.29.2

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "util-linux 2.29.2"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/util-linux-2.29.2 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--disable-rpath \
	--disable-makeinstall-chown \
	--disable-chfn-chsh \
	--disable-login \
	--disable-nologin \
	--disable-su \
	--disable-setpriv \
	--disable-runuser \
	--disable-pylibmount \
	--disable-static \
	--without-python \
	--without-systemd \
	--without-systemdsystemunitdir )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/util-linux-2.29.2
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/util-linux-2.29.2
	@rm -rf $(BUILD_DIR)/util-linux-2.29.2

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "util-linux 2.29.2"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@mkdir -pv $(ROOTFS_DIR)/var/lib/hwclock
	@( cd $(BUILD_DIR)/util-linux-2.29.2 && \
	./configure \
	ADJTIME_PATH=/var/lib/hwclock/adjtime \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--docdir=/usr/share/doc/util-linux-2.29.2 \
	--disable-rpath \
	--disable-makeinstall-chown \
	--disable-chfn-chsh \
	--disable-login \
	--disable-nologin \
	--disable-su \
	--disable-setpriv \
	--disable-runuser \
	--disable-pylibmount \
	--disable-static \
	--without-python \
	--without-systemd \
	--without-systemdsystemunitdir )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/util-linux-2.29.2
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/util-linux-2.29.2
	@rm -rf $(BUILD_DIR)/util-linux-2.29.2
