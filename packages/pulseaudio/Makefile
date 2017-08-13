include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/pulseaudio-10.99.1.tar.xz
SOURCE_URL := https://freedesktop.org/software/pulseaudio/releases/pulseaudio-10.99.1.tar.xz
MD5 := ed61155c1ba8e22ad147024d0f284d06

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "pulseaudio 10.99.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/pulseaudio-10.99.1 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--disable-bluez4 \
	--disable-bluez5 \
	--disable-rpath )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/pulseaudio-10.99.1
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/pulseaudio-10.99.1
	@rm -fv $(SYSROOT_DIR)/etc/dbus-1/system.d/pulseaudio-system.conf
	@sed -i '/load-module module-console-kit/s/^/#/' $(SYSROOT_DIR)/etc/pulse/default.pa
	@rm -rf $(BUILD_DIR)/pulseaudio-10.99.1

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "pulseaudio 10.99.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/pulseaudio-10.99.1 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--disable-bluez4 \
	--disable-bluez5 \
	--disable-rpath )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/pulseaudio-10.99.1
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/pulseaudio-10.99.1
	@rm -fv $(ROOTFS_DIR)/etc/dbus-1/system.d/pulseaudio-system.conf
	@sed -i '/load-module module-console-kit/s/^/#/' $(ROOTFS_DIR)/etc/pulse/default.pa
	@rm -rf $(BUILD_DIR)/pulseaudio-10.99.1
