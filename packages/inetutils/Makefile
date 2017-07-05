include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/inetutils-1.9.4.tar.xz
SOURCE_URL := http://ftp.gnu.org/gnu/inetutils/inetutils-1.9.4.tar.xz
MD5 := 87fef1fa3f603aef11c41dcc097af75e

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "inetutils 1.9.4"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/inetutils/inetutils-1.9-PATH_PROCNET_DEV.patch -d $(BUILD_DIR)/inetutils-1.9.4
	@( cd $(BUILD_DIR)/inetutils-1.9.4 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--localstatedir=/var \
	--disable-logger \
	--disable-whois \
	--disable-rcp \
	--disable-rexec \
	--disable-rlogin \
	--disable-rsh \
	--disable-servers )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/inetutils-1.9.4
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/inetutils-1.9.4
	@mv -v $(ROOTFS_DIR)/usr/bin/hostname $(ROOTFS_DIR)/bin
	@mv -v $(ROOTFS_DIR)/usr/bin/ping $(ROOTFS_DIR)/bin
	@mv -v $(ROOTFS_DIR)/usr/bin/ping6 $(ROOTFS_DIR)/bin
	@mv -v $(ROOTFS_DIR)/usr/bin/traceroute $(ROOTFS_DIR)/bin
	@chmod -v 755 $(ROOTFS_DIR)/bin/ping
	@chmod -v 755 $(ROOTFS_DIR)/bin/ping6
	@chmod -v 755 $(ROOTFS_DIR)/bin/traceroute
	@mv -v $(ROOTFS_DIR)/usr/bin/ifconfig $(ROOTFS_DIR)/sbin
	@rm -rf $(BUILD_DIR)/inetutils-1.9.4
