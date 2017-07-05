include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/bash-4.4.tar.gz
SOURCE_URL := http://ftp.gnu.org/gnu/bash/bash-4.4.tar.gz
MD5 := 148888a7c95ac23705559b6f477dfe25

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "bash 4.4"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/bash/bash-4.4-upstream_fixes-1.patch -d $(BUILD_DIR)/bash-4.4
	@( cd $(BUILD_DIR)/bash-4.4 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--docdir=/usr/share/doc/bash-4.4 \
	--without-bash-malloc \
	--with-installed-readline )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/bash-4.4
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/bash-4.4
	@mv -vf $(ROOTFS_DIR)/usr/bin/bash $(ROOTFS_DIR)/bin
	@ln -svf bash $(ROOTFS_DIR)/bin/sh
	@rm -rf $(BUILD_DIR)/bash-4.4
