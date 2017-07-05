include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/sed-4.4.tar.xz
SOURCE_URL := http://ftp.gnu.org/gnu/sed/sed-4.4.tar.xz
MD5 := e0c583d4c380059abd818cd540fe6938

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "sed 4.4"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -i 's/usr/tools/' $(BUILD_DIR)/sed-4.4/build-aux/help2man
	@sed -i 's/panic-tests.sh//' $(BUILD_DIR)/sed-4.4/Makefile.in
	@( cd $(BUILD_DIR)/sed-4.4 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--bindir=/bin )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/sed-4.4
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/sed-4.4
	@rm -rf $(BUILD_DIR)/sed-4.4
