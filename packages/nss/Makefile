include $(SUPPORT_DIR)/functions.mk

NAME := nss
HOST_DEPENDENCIES := nspr zlib
TARGET_DEPENDENCIES := nspr sqlite p11-kit
SOURCE := $(SOURCES_DIR)/nss-3.32.tar.gz
SOURCE_URL := https://ftp.mozilla.org/pub/security/nss/releases/NSS_3_32_RTM/src/nss-3.32.tar.gz
MD5 := 076abf8ed88b6bb28f3396b072d252ed

ifeq ($(shell uname -m),x86_64)
HOST_64BIT_OPTION = USE_64=1
endif

TARGET_OS_TEST = arm

ifeq ($(CONFIG_LINUX_ARCH),arm64)
TARGET_64BIT_OPTION = USE_64=1
TARGET_OS_TEST = aarch64
endif

toolchain:
	@$(STEP) "nss 3.32"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@make -j1 SOURCE_MD_DIR=$(BUILD_DIR)/nss-3.32/nss/dist DIST=$(BUILD_DIR)/nss-3.32/nss/dist BUILD_OPT=1 NSPR_INCLUDE_DIR=$(TOOLS_DIR)/usr/include/nspr USE_SYSTEM_ZLIB=1 ZLIB_LIBS=-lz NSS_ENABLE_WERROR=0 $(HOST_64BIT_OPTION) -C $(BUILD_DIR)/nss-3.32/nss
	@install -v -m 755 -t $(TOOLS_DIR)/usr/lib/ $(BUILD_DIR)/nss-3.32/nss/dist/lib/*.so
	@install -v -m 755 -d $(TOOLS_DIR)/usr/include/nss
	@install -v -m 644 -t $(TOOLS_DIR)/usr/include/nss $(BUILD_DIR)/nss-3.32/dist/public/nss/*
	@install -v -m 755 -t $(TOOLS_DIR)/usr/lib/ $(BUILD_DIR)/nss-3.32/nss/dist/lib/*.a
	@install -Dv -m 0644 $(PACKAGES_DIR)/nss/nss.pc.in $(TOOLS_DIR)/usr/lib/pkgconfig/nss.pc
	@sed -i -e 's/@VERSION@/3.32/g;' $(TOOLS_DIR)/usr/lib/pkgconfig/nss.pc
	@rm -rf $(BUILD_DIR)/nss-3.32
	@echo $(NAME) >> $(TOOLCHAIN_DEPENDENCIES)

system:
	@$(STEP) "nss 3.32"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++ AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip make -j1 coreconf SOURCE_MD_DIR=$(BUILD_DIR)/nss-3.32/nss/dist DIST=$(BUILD_DIR)/nss-3.32/nss/dist CHECKLOC= MOZILLA_CLIENT=1 NSPR_INCLUDE_DIR=$(SYSROOT_DIR)/usr/include/nspr NSPR_LIB_DIR=$(SYSROOT_DIR)/usr/lib BUILD_OPT=1 NS_USE_GCC=1 NSS_DISABLE_GTESTS=1 NSS_USE_SYSTEM_SQLITE=1 $(TARGET_64BIT_OPTION) NSS_ENABLE_ECC=1 NATIVE_CC="gcc" OS_ARCH="Linux" OS_RELEASE="2.6" OS_TEST=$(TARGET_OS_TEST) -C $(BUILD_DIR)/nss-3.32/nss
	@CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++ AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip make -j1 lib/dbm all SOURCE_MD_DIR=$(BUILD_DIR)/nss-3.32/nss/dist DIST=$(BUILD_DIR)/nss-3.32/nss/dist CHECKLOC= MOZILLA_CLIENT=1 NSPR_INCLUDE_DIR=$(SYSROOT_DIR)/usr/include/nspr NSPR_LIB_DIR=$(SYSROOT_DIR)/usr/lib BUILD_OPT=1 NS_USE_GCC=1 NSS_DISABLE_GTESTS=1 NSS_USE_SYSTEM_SQLITE=1 $(TARGET_64BIT_OPTION) NSS_ENABLE_ECC=1 NATIVE_CC="gcc" OS_ARCH="Linux" OS_RELEASE="2.6" OS_TEST=$(TARGET_OS_TEST) NATIVE_FLAGS="-O2 -I$(TOOLS_DIR)/include" -C $(BUILD_DIR)/nss-3.32/nss
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
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
