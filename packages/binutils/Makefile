include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/binutils-2.28.tar.bz2
SOURCE_URL := http://ftpmirror.gnu.org/gnu/binutils/binutils-2.28.tar.bz2
MD5 := 9e8340c96626b469a603c15c9d843727

toolchain:
	@$(STEP) "binutils 2.28"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	# @patch -Np1 -i $(PACKAGES_DIR)/binutils/sh-conf.patch -d $(BUILD_DIR)/binutils-2.28
	# @patch -Np1 -i $(PACKAGES_DIR)/binutils/ld-makefile.patch -d $(BUILD_DIR)/binutils-2.28
	# @patch -Np1 -i $(PACKAGES_DIR)/binutils/check-ldrunpath-length.patch -d $(BUILD_DIR)/binutils-2.28
	# @patch -Np1 -i $(PACKAGES_DIR)/binutils/add-sysroot-fix-from-bug-3049.patch -d $(BUILD_DIR)/binutils-2.28
	# @patch -Np1 -i $(PACKAGES_DIR)/binutils/poison-system-directories.patch -d $(BUILD_DIR)/binutils-2.28
	# @patch -Np1 -i $(PACKAGES_DIR)/binutils/Fixes-LINKER-BUG-.rofixup-section-size-mismatch.patch -d $(BUILD_DIR)/binutils-2.28
	# @patch -Np1 -i $(PACKAGES_DIR)/binutils/xtensa-ld-restore-old-section-sorting-behavior.patch -d $(BUILD_DIR)/binutils-2.28
	# @patch -Np1 -i $(PACKAGES_DIR)/binutils/xtensa-fix-memory-corruption-by-broken-sysregs.patch -d $(BUILD_DIR)/binutils-2.28
	@mkdir -pv $(BUILD_DIR)/binutils-2.28/binutils-build
	@( cd $(BUILD_DIR)/binutils-2.28/binutils-build && \
	AR="ar" \
	AS="as" \
	$(BUILD_DIR)/binutils-2.28/configure \
	--prefix=$(TOOLS_DIR) \
	--sysconfdir=$(TOOLS_DIR)/etc \
	--localstatedir=$(TOOLS_DIR)/var \
	--enable-shared \
	--disable-static \
	--disable-multilib \
	--disable-werror \
	--target=$(CONFIG_TARGET) \
	--disable-shared \
	--enable-static \
	--with-sysroot=$(SYSROOT_DIR) \
	--enable-poison-system-directories \
	--disable-sim \
	--disable-gdb )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/binutils-2.28/binutils-build
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/binutils-2.28/binutils-build
	@rm -rf $(BUILD_DIR)/binutils-2.28

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "binutils 2.28"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@mkdir -pv $(BUILD_DIR)/binutils-2.28/binutils-build
	@( cd $(BUILD_DIR)/binutils-2.28/binutils-build && \
	$(BUILD_DIR)/binutils-2.28/configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--enable-gold \
	--enable-ld=default \
	--enable-plugins \
	--enable-shared \
	--disable-werror \
	--with-system-zlib )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/binutils-2.28/binutils-build
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/binutils-2.28/binutils-build
	@rm -rf $(BUILD_DIR)/binutils-2.28
