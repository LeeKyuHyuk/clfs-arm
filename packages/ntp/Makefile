include $(SUPPORT_DIR)/functions.mk

NAME := ntp
TARGET_DEPENDENCIES := libcap wget openssl
SOURCE := $(SOURCES_DIR)/ntp-4.2.8p9.tar.gz
SOURCE_URL := https://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-4.2/ntp-4.2.8p9.tar.gz
MD5 := 857452b05f5f2e033786f77ade1974ed

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "ntp 4.2.8p9"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
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
	@echo 'ntp:x:87:' >> $(ROOTFS_DIR)/etc/group
	@echo 'ntp:x:87:87:Network Time Protocol:/var/lib/ntp:/bin/false' >> $(ROOTFS_DIR)/etc/passwd
	@mkdir -pv $(ROOTFS_DIR)/var/lib/ntp
	@install -Dv -m 644 $(PACKAGES_DIR)/ntp/ntpd.service $(ROOTFS_DIR)/usr/lib/systemd/system/ntpd.service
	@mkdir -p $(ROOTFS_DIR)/etc/systemd/system/multi-user.target.wants
	@ln -fs ../../../../usr/lib/systemd/system/ntpd.service $(ROOTFS_DIR)/etc/systemd/system/multi-user.target.wants/ntpd.service
	@rm -rf $(BUILD_DIR)/ntp-4.2.8p9
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
