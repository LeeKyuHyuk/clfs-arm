include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/dbus-1.10.22.tar.gz
SOURCE_URL := https://dbus.freedesktop.org/releases/dbus/dbus-1.10.22.tar.gz
MD5 := baaa10b7cb49086ad91179a8decfadc5

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "dbus 1.10.22"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/dbus-1.10.22 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--sysconfdir=$(SYSROOT_DIR)/etc \
	--localstatedir=$(SYSROOT_DIR)/var \
	--disable-doxygen-docs \
	--disable-xml-docs \
	--disable-static )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/dbus-1.10.22
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/dbus-1.10.22
	@rm -rf $(BUILD_DIR)/dbus-1.10.22

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "dbus 1.10.22"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/dbus-1.10.22 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--disable-doxygen-docs \
	--disable-xml-docs \
	--disable-static \
	--docdir=/usr/share/doc/dbus-1.10.18 \
	--with-console-auth-dir=/run/console \
	--with-system-pid-file=/run/dbus/pid \
	--with-system-socket=/run/dbus/system_bus_socket )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/dbus-1.10.22
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/dbus-1.10.22
	@echo 'messagebus:x:18:' >> $(ROOTFS_DIR)/etc/group
	@echo 'messagebus:x:18:18:D-Bus Message Daemon User:/var/run/dbus:/bin/false' >> $(ROOTFS_DIR)/etc/passwd
	@cp -v $(PACKAGES_DIR)/dbus/session-local.conf $(ROOTFS_DIR)/etc/dbus-1/session-local.conf
	@rm -rf $(BUILD_DIR)/dbus-1.10.22
