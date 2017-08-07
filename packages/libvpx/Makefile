include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/libvpx-1.6.1.tar.bz2
SOURCE_URL := http://storage.googleapis.com/downloads.webmproject.org/releases/webm/libvpx-1.6.1.tar.bz2
MD5 := a19518c8111fa93bdabdd85259162611

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "libvpx 1.6.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/libvpx-1.6.1 && \
	LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc \
	CROSS=$(CONFIG_TARGET)- \
	$(BUILD_DIR)/libvpx-1.6.1/configure \
	--target="generic-gnu" \
	--prefix=$(SYSROOT_DIR)/usr \
	--enable-pic \
	--enable-shared \
	--disable-static \
	--disable-examples \
	--disable-docs \
	--disable-unit-tests )
	@ln -svf $(BUILD_DIR)/libvpx-1.6.1/libs-generic-gnu.mk $(WORKSPACE_DIR)/configlibs-generic-gnu.mk
	@make -j$(CONFIG_PARALLEL_JOBS) all -C $(BUILD_DIR)/libvpx-1.6.1
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/libvpx-1.6.1
	@mkdir -pv $(SYSROOT_DIR)/usr/include/vpx
	@cp -Rv $(BUILD_DIR)/libvpx-1.6.1/vpx/*.h $(SYSROOT_DIR)/usr/include/vpx
	@rm -rf $(WORKSPACE_DIR)/configlibs-generic-gnu.mk
	@rm -rf $(BUILD_DIR)/libvpx-1.6.1

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "libvpx 1.6.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/libvpx-1.6.1 && \
	LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc \
	CROSS=$(CONFIG_TARGET)- \
	$(BUILD_DIR)/libvpx-1.6.1/configure \
	--target="generic-gnu" \
	--prefix=/usr \
	--enable-pic \
	--enable-shared \
	--disable-static \
	--disable-examples \
	--disable-docs \
	--disable-unit-tests )
	@ln -svf $(BUILD_DIR)/libvpx-1.6.1/libs-generic-gnu.mk $(WORKSPACE_DIR)/configlibs-generic-gnu.mk
	@make -j$(CONFIG_PARALLEL_JOBS) all -C $(BUILD_DIR)/libvpx-1.6.1
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/libvpx-1.6.1
	@mkdir -pv $(ROOTFS_DIR)/usr/include/vpx
	@cp -Rv $(BUILD_DIR)/libvpx-1.6.1/vpx/*.h $(ROOTFS_DIR)/usr/include/vpx
	@rm -rf $(WORKSPACE_DIR)/configlibs-generic-gnu.mk
	@rm -rf $(BUILD_DIR)/libvpx-1.6.1
