include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/bc-1.06.95.tar.bz2
SOURCE_URL := http://alpha.gnu.org/gnu/bc/bc-1.06.95.tar.bz2
MD5 := 5126a721b73f97d715bb72c13c889035

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "bc 1.06.95"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/bc/array_initialize.patch -d $(BUILD_DIR)/bc-1.06.95
	@patch -Np1 -i $(PACKAGES_DIR)/bc/notice_read_write_errors.patch -d $(BUILD_DIR)/bc-1.06.95
	@patch -Np1 -i $(PACKAGES_DIR)/bc/use_appropiate_makeinfo.patch -d $(BUILD_DIR)/bc-1.06.95
	@( cd $(BUILD_DIR)/bc-1.06.95 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--with-readline \
	--mandir=/usr/share/man \
	--infodir=/usr/share/info )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/bc-1.06.95
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/bc-1.06.95
	@rm -rf $(BUILD_DIR)/bc-1.06.95
