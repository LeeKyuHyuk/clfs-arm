include $(SUPPORT_DIR)/functions.mk

SOURCE := $(PACKAGES_DIR)/cacerts/make-ca.sh-20170514
SOURCE_URL := http://anduin.linuxfromscratch.org/BLFS/other/make-ca.sh-20170514
MD5 := bc851e234a2a9c834c10d81ea02119b8

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
	@install -vdm755 $(ROOTFS_DIR)/etc/ssl/local
	@mkdir -p $(BUILD_DIR)/cacerts
	@wget http://www.cacert.org/certs/root.crt -P $(BUILD_DIR)/cacerts
	@$(TOOLS_DIR)/bin/openssl x509 -in $(BUILD_DIR)/cacerts/root.crt -text -fingerprint -setalias "CAcert Class 1 root" -addtrust serverAuth -addtrust emailProtection -addtrust codeSigning > $(ROOTFS_DIR)/etc/ssl/local/CAcert_Class_1_root.pem
	@chmod -v 755 $(SOURCE)
	@rm -rf  $(BUILD_DIR)/cacerts
