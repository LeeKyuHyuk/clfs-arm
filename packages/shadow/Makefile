include $(SUPPORT_DIR)/functions.mk

SOURCE := $(PACKAGES_DIR)/shadow/shadow-4.5.tar.xz
SOURCE_URL := https://github.com/shadow-maint/shadow/releases/download/4.5/shadow-4.5.tar.xz
MD5 := c350da50c2120de6bb29177699d89fe3

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "shadow 4.5"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -i 's/groups$(EXEEXT) //' $(BUILD_DIR)/shadow-4.5/src/Makefile.in
	@find $(BUILD_DIR)/shadow-4.5/man -name Makefile.in -exec sed -i 's/groups\.1 / /'   {} \;
	@find $(BUILD_DIR)/shadow-4.5/man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \;
	@find $(BUILD_DIR)/shadow-4.5/man -name Makefile.in -exec sed -i 's/passwd\.5 / /'   {} \;
	@sed -i -e 's|#ENCRYPT_METHOD DES|ENCRYPT_METHOD SHA512|' -e 's|/var/spool/mail|/var/mail|' $(BUILD_DIR)/shadow-4.5/etc/login.defs
	@sed -i 's/1000/999/' $(BUILD_DIR)/shadow-4.5/etc/useradd
	@( cd $(BUILD_DIR)/shadow-4.5 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--sysconfdir=/etc \
	--with-group-name-max-length=32 )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/shadow-4.5
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/shadow-4.5
	@sed -i 's/yes/no/' $(ROOTFS_DIR)/etc/default/useradd
	@install -v -m644 $(ROOTFS_DIR)/etc/login.defs $(ROOTFS_DIR)/etc/login.defs.orig
	@for FUNCTION in FAIL_DELAY \
									FAILLOG_ENAB \
									LASTLOG_ENAB \
									MAIL_CHECK_ENAB \
									OBSCURE_CHECKS_ENAB \
									PORTTIME_CHECKS_ENAB \
									QUOTAS_ENAB \
									CONSOLE MOTD_FILE \
									FTMP_FILE NOLOGINS_FILE \
									ENV_HZ PASS_MIN_LEN \
									SU_WHEEL_ONLY \
									CRACKLIB_DICTPATH \
									PASS_CHANGE_TRIES \
									PASS_ALWAYS_WARN \
									CHFN_AUTH \
									ENCRYPT_METHOD \
									ENVIRON_FILE \
									; do \
    sed -i "s/^$${FUNCTION}/# &/" $(ROOTFS_DIR)/etc/login.defs ; \
	done
	@cp -v $(PACKAGES_DIR)/shadow/login $(ROOTFS_DIR)/etc/pam.d/login
	@cp -v $(PACKAGES_DIR)/shadow/passwd $(ROOTFS_DIR)/etc/pam.d/passwd
	@cp -v $(PACKAGES_DIR)/shadow/su $(ROOTFS_DIR)/etc/pam.d/su
	@cp -v $(PACKAGES_DIR)/shadow/chage $(ROOTFS_DIR)/etc/pam.d/chage
	@for PROGRAM in chfn chgpasswd chpasswd chsh groupadd groupdel groupmems groupmod newusers useradd userdel usermod ; do \
		install -v -m644 $(ROOTFS_DIR)/etc/pam.d/chage $(ROOTFS_DIR)/etc/pam.d/$${PROGRAM} ; \
		sed -i "s/chage/$${PROGRAM}/" $(ROOTFS_DIR)/etc/pam.d/$${PROGRAM} ; \
	done
	@rm -rf $(BUILD_DIR)/shadow-4.5
