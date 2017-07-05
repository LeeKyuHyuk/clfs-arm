include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/sysklogd-1.5.1.tar.gz
SOURCE_URL := http://www.infodrom.org/projects/sysklogd/download/sysklogd-1.5.1.tar.gz
MD5 := c70599ab0d037fde724f7210c2c8d7f8

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "sysklogd 1.5.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -i '/Error loading kernel symbols/{n;n;d}' $(BUILD_DIR)/sysklogd-1.5.1/ksym_mod.c
	@sed -i 's/union wait/int/' $(BUILD_DIR)/sysklogd-1.5.1/syslogd.c
	@make -j$(CONFIG_PARALLEL_JOBS) CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc -C $(BUILD_DIR)/sysklogd-1.5.1
	@install -D -m 0500 $(BUILD_DIR)/sysklogd-1.5.1/syslogd $(ROOTFS_DIR)/sbin/syslogd
	@install -D -m 0500 $(BUILD_DIR)/sysklogd-1.5.1/klogd $(ROOTFS_DIR)/sbin/klogd
	@install -D -m 0644 $(PACKAGES_DIR)/sysklogd/syslog.conf $(ROOTFS_DIR)/etc/syslog.conf
	@rm -rf $(BUILD_DIR)/sysklogd-1.5.1
