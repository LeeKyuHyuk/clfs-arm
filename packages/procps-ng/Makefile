include $(SUPPORT_DIR)/functions.mk

NAME := procps-ng
TARGET_DEPENDENCIES := ncurses
SOURCE := $(SOURCES_DIR)/procps-ng-3.3.12.tar.xz
SOURCE_URL := http://sourceforge.net/projects/procps-ng/files/Production/procps-ng-3.3.12.tar.xz
MD5 := 957e42e8b193490b2111252e4a2b443c

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "procps-ng 3.3.12"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/procps-ng-3.3.12 && \
	ac_cv_func_malloc_0_nonnull=yes \
	ac_cv_func_realloc_0_nonnull=yes \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--exec-prefix= \
	--libdir=/usr/lib \
	--disable-static \
	--disable-kill \
	--with-systemd )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/procps-ng-3.3.12
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/procps-ng-3.3.12
	@mv -v $(ROOTFS_DIR)/usr/lib/libprocps.so.* $(ROOTFS_DIR)/lib
	@ln -sfv ../../lib/`readlink $(ROOTFS_DIR)/usr/lib/libprocps.so` $(ROOTFS_DIR)/usr/lib/libprocps.so
	@rm -rf $(BUILD_DIR)/procps-ng-3.3.12
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
