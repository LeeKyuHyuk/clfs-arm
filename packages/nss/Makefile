include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/nss-3.32.tar.gz
SOURCE_URL := https://ftp.mozilla.org/pub/security/nss/releases/NSS_3_32_RTM/src/nss-3.32.tar.gz
MD5 := 076abf8ed88b6bb28f3396b072d252ed

system:
	@$(STEP) "nss 3.32"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++ AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip make -j1 coreconf SOURCE_MD_DIR=$(BUILD_DIR)/nss-3.32/nss/dist DIST=$(BUILD_DIR)/nss-3.32/nss/dist CHECKLOC= MOZILLA_CLIENT=1 NSPR_INCLUDE_DIR=$(SYSROOT_DIR)/usr/include/nspr NSPR_LIB_DIR=$(SYSROOT_DIR)/usr/lib BUILD_OPT=1 NS_USE_GCC=1 NSS_DISABLE_GTESTS=1 NSS_USE_SYSTEM_SQLITE=1 NSS_ENABLE_ECC=1 NATIVE_CC="gcc" OS_ARCH="Linux" OS_RELEASE="2.6" OS_TEST="arm" -C $(BUILD_DIR)/nss-3.32/nss
	@CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++ AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip make -j1 lib/dbm all SOURCE_MD_DIR=$(BUILD_DIR)/nss-3.32/nss/dist DIST=$(BUILD_DIR)/nss-3.32/nss/dist CHECKLOC= MOZILLA_CLIENT=1 NSPR_INCLUDE_DIR=$(SYSROOT_DIR)/usr/include/nspr NSPR_LIB_DIR=$(SYSROOT_DIR)/usr/lib BUILD_OPT=1 NS_USE_GCC=1 NSS_DISABLE_GTESTS=1 NSS_USE_SYSTEM_SQLITE=1 NSS_ENABLE_ECC=1 NATIVE_CC="gcc" OS_ARCH="Linux" OS_RELEASE="2.6" OS_TEST="arm" NATIVE_FLAGS="-O2 -I$(TOOLS_DIR)/include" -C $(BUILD_DIR)/nss-3.32/nss
	@install -v -m 755 -t $(SYSROOT_DIR)/usr/lib/ $(BUILD_DIR)/nss-3.32/nss/dist/lib/*.so
	@install -v -m 755 -d $(SYSROOT_DIR)/usr/include/nss
	@install -v -m 644 -t $(SYSROOT_DIR)/usr/include/nss $(BUILD_DIR)/nss-3.32/dist/public/nss/*
	@install -v -m 755 -t $(SYSROOT_DIR)/usr/lib/ $(BUILD_DIR)/nss-3.32/nss/dist/lib/*.a
	@install -Dv -m 0644 $(PACKAGES_DIR)/nss/nss.pc.in $(SYSROOT_DIR)/usr/lib/pkgconfig/nss.pc
	@sed -i -e 's/@VERSION@/3.32/g;' $(SYSROOT_DIR)/usr/lib/pkgconfig/nss.pc
	@install -v -m 755 -t $(ROOTFS_DIR)/usr/lib/ $(BUILD_DIR)/nss-3.32/nss/dist/lib/*.so
	@install -v -m 755 -d $(ROOTFS_DIR)/usr/include/nss
	@install -v -m 644 -t $(ROOTFS_DIR)/usr/include/nss $(BUILD_DIR)/nss-3.32/dist/public/nss/*
	@install -v -m 755 -t $(ROOTFS_DIR)/usr/lib/ $(BUILD_DIR)/nss-3.32/nss/dist/lib/*.a
	@install -Dv -m 0644 $(PACKAGES_DIR)/nss/nss.pc.in $(ROOTFS_DIR)/usr/lib/pkgconfig/nss.pc
	@sed -i -e 's/@VERSION@/3.32/g;' $(ROOTFS_DIR)/usr/lib/pkgconfig/nss.pc
	@rm -rf $(BUILD_DIR)/nss-3.32
