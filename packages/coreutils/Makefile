include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/coreutils-8.27.tar.xz
SOURCE_URL := http://ftp.gnu.org/gnu/coreutils/coreutils-8.27.tar.xz
MD5 := 502795792c212932365e077946d353ae

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "coreutils 8.27"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/coreutils/coreutils-8.27-i18n-1.patch -d $(BUILD_DIR)/coreutils-8.27
	@sed -i 's#/man/help2man#/man/help2man --no-discard-stderr#g' $(BUILD_DIR)/coreutils-8.27/man/local.mk
	@( cd $(BUILD_DIR)/coreutils-8.27 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--enable-no-install-program=kill,uptime )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/coreutils-8.27
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/coreutils-8.27
	@for file in cat chgrp chmod chown cp date dd df echo false ln ls mkdir mknod mv pwd rm rmdir stty sync true uname ; do \
		mv -v $(ROOTFS_DIR)/usr/bin/$${file} $(ROOTFS_DIR)/bin/$${file} ; \
	done
	@mv -v $(ROOTFS_DIR)/usr/bin/chroot $(ROOTFS_DIR)/usr/sbin
	@mv -v $(ROOTFS_DIR)/usr/share/man/man1/chroot.1 $(ROOTFS_DIR)/usr/share/man/man8/chroot.8
	@sed -i s/\"1\"/\"8\"/1 $(ROOTFS_DIR)/usr/share/man/man8/chroot.8
	@for file in head sleep nice test [ ; do \
		mv -v $(ROOTFS_DIR)/usr/bin/$${file} $(ROOTFS_DIR)/bin/$${file} ; \
	done
	@rm -rf $(BUILD_DIR)/coreutils-8.27
