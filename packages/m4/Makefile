include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/m4-1.4.18.tar.xz
SOURCE_URL := http://ftp.gnu.org/gnu/m4/m4-1.4.18.tar.xz
MD5 := 730bb15d96fffe47e148d1e09235af82

toolchain:
	@$(STEP) "m4 1.4.18"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/m4-1.4.18 && ./configure --prefix=$(TOOLS_DIR)/usr )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/m4-1.4.18
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/m4-1.4.18
	@rm -rf $(BUILD_DIR)/m4-1.4.18

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "m4 1.4.18"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	( cd $(BUILD_DIR)/m4-1.4.18 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr )
	make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/m4-1.4.18
	make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/m4-1.4.18
	rm -rf $(BUILD_DIR)/m4-1.4.18
