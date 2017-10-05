include $(SUPPORT_DIR)/functions.mk

NAME := cacerts
SOURCE := $(PACKAGES_DIR)/cacerts/ca-certificates_20161130.tar.xz
SOURCE_URL := http://snapshot.debian.org/archive/debian/20161205T153846Z/pool/main/c/ca-certificates/ca-certificates_20161130.tar.xz
MD5 := 1a0a3a1b3390dc83affed4b0c2ae1c05

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "Certificate Authority Certificates"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/ca-certificates all
	@install -dv -m 0755 $(ROOTFS_DIR)/usr/share/ca-certificates
	@install -dv -m 0755 $(ROOTFS_DIR)/etc/ssl/certs
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/ca-certificates install DESTDIR=$(ROOTFS_DIR)
	@rm -f $(ROOTFS_DIR)/usr/sbin/update-ca-certificates
	@rm -f $(ROOTFS_DIR)/etc/ssl/certs/*
	@( cd $(ROOTFS_DIR) && \
	for i in `find usr/share/ca-certificates -name "*.crt"` ; do \
		ln -sf ../../../$$i etc/ssl/certs/`basename $${i} .crt`.pem ;\
		cat $$i >>etc/ssl/certs/ca-certificates.crt ;\
	done )
	@$(TOOLS_DIR)/bin/c_rehash $(ROOTFS_DIR)/etc/ssl/certs
	@rm -rf $(BUILD_DIR)/ca-certificates
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
