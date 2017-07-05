include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/ntp-4.2.8p9.tar.gz
SOURCE_URL := https://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-4.2/ntp-4.2.8p9.tar.gz
MD5 := 857452b05f5f2e033786f77ade1974ed

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "ntp 4.2.8p9"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/ntp-4.2.8p9 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--bindir=/usr/sbin \
	--sysconfdir=/etc \
	--enable-linuxcaps \
	--with-yielding-select=yes \
	--with-lineeditlibs=readline \
	--docdir=/usr/share/doc/ntp-4.2.8p9 )
	@make -j1 -C $(BUILD_DIR)/ntp-4.2.8p9
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/ntp-4.2.8p9
	@cp -v $(PACKAGES_DIR)/ntp/ntp.conf $(ROOTFS_DIR)/etc/ntp.conf
	@cp -v $(PACKAGES_DIR)/ntp/ntpd $(ROOTFS_DIR)/etc/rc.d/init.d/ntpd
	@chmod -v 755 $(ROOTFS_DIR)/etc/rc.d/init.d/ntpd
	@ln -svf ../init.d/ntpd $(ROOTFS_DIR)/etc/rc.d/rc0.d/K46ntpd
	@ln -svf ../init.d/ntpd $(ROOTFS_DIR)/etc/rc.d/rc1.d/K46ntpd
	@ln -svf ../init.d/ntpd $(ROOTFS_DIR)/etc/rc.d/rc2.d/K46ntpd
	@ln -svf ../init.d/ntpd $(ROOTFS_DIR)/etc/rc.d/rc3.d/S26ntpd
	@ln -svf ../init.d/ntpd $(ROOTFS_DIR)/etc/rc.d/rc4.d/S26ntpd
	@ln -svf ../init.d/ntpd $(ROOTFS_DIR)/etc/rc.d/rc5.d/S26ntpd
	@ln -svf ../init.d/ntpd $(ROOTFS_DIR)/etc/rc.d/rc6.d/K46ntpd
	@echo 'ntp:x:87:' >> $(ROOTFS_DIR)/etc/group
	@echo 'ntp:x:87:87:Network Time Protocol:/var/lib/ntp:/bin/false' >> $(ROOTFS_DIR)/etc/passwd
	@mkdir -pv $(ROOTFS_DIR)/var/lib/ntp
	@rm -rf $(BUILD_DIR)/ntp-4.2.8p9
