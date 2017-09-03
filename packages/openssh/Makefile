include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/openssh-7.4p1.tar.gz
SOURCE_URL := http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-7.4p1.tar.gz
MD5 := b2db2a83caf66a208bb78d6d287cdaa3

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "openssh 7.4p1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/openssh-7.4p1 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--sysconfdir=/etc/ssh \
	--with-md5-passwords \
	--with-privsep-path=/var/lib/sshd \
	--disable-strip )
	@make -j$(CONFIG_PARALLEL_JOBS) LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc -C $(BUILD_DIR)/openssh-7.4p1
	@install -v -m700 -d $(ROOTFS_DIR)/var/lib/sshd
	@rm -rf $(ROOTFS_DIR)/usr/share/man/man8
	@make -j$(CONFIG_PARALLEL_JOBS) LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/openssh-7.4p1
	@install -v -m755 $(BUILD_DIR)/openssh-7.4p1/contrib/ssh-copy-id $(ROOTFS_DIR)/usr/bin
	@echo 'sshd:x:50:' >> $(ROOTFS_DIR)/etc/group
	@echo 'sshd:x:50:50:sshd PrivSep:/var/lib/sshd:/bin/false' >> $(ROOTFS_DIR)/etc/passwd
	@echo "PermitRootLogin yes" >> $(ROOTFS_DIR)/etc/ssh/sshd_config
	@echo "PasswordAuthentication yes" >> $(ROOTFS_DIR)/etc/ssh/sshd_config
	@install -Dv -m 644 $(PACKAGES_DIR)/openssh/sshd.service $(ROOTFS_DIR)/usr/lib/systemd/system/sshd.service
	@mkdir -p $(ROOTFS_DIR)/etc/systemd/system/multi-user.target.wants
	@ln -fs ../../../../usr/lib/systemd/system/sshd.service $(ROOTFS_DIR)/etc/systemd/system/multi-user.target.wants/sshd.service
	@rm -rf $(BUILD_DIR)/openssh-7.4p1
