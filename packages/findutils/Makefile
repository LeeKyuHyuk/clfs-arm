include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/findutils-4.6.0.tar.gz
SOURCE_URL := http://ftpmirror.gnu.org/gnu/findutils/findutils-4.6.0.tar.gz
MD5 := 9936aa8009438ce185bea2694a997fc1

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "findutils 4.6.0"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/findutils-4.6.0 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--localstatedir=/var/lib/locate )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/findutils-4.6.0
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/findutils-4.6.0
	@mv -v $(ROOTFS_DIR)/usr/bin/find $(ROOTFS_DIR)/bin
	@sed -i 's/find:=${BINDIR}/find:=\/bin/' $(ROOTFS_DIR)/usr/bin/updatedb
	@rm -rf $(BUILD_DIR)/findutils-4.6.0
