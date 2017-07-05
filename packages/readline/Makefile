include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/readline-7.0.tar.gz
SOURCE_URL := http://ftp.gnu.org/gnu/readline/readline-7.0.tar.gz
MD5 := 205b03a87fc83dab653b628c59b9fc91

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "readline 7.0"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -i '/MV.*old/d' $(BUILD_DIR)/readline-7.0/Makefile.in
	@sed -i '/{OLDSUFF}/c:' $(BUILD_DIR)/readline-7.0/support/shlib-install
	@( cd $(BUILD_DIR)/readline-7.0 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--disable-static )
	@make -j$(CONFIG_PARALLEL_JOBS) SHLIB_LIBS="-lncursesw" -C $(BUILD_DIR)/readline-7.0
	@make -j$(CONFIG_PARALLEL_JOBS) SHLIB_LIBS="-lncurses" install -C $(BUILD_DIR)/readline-7.0
	@rm -rf $(BUILD_DIR)/readline-7.0

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "readline 7.0"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -i '/MV.*old/d' $(BUILD_DIR)/readline-7.0/Makefile.in
	@sed -i '/{OLDSUFF}/c:' $(BUILD_DIR)/readline-7.0/support/shlib-install
	@( cd $(BUILD_DIR)/readline-7.0 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--disable-static )
	@make -j$(CONFIG_PARALLEL_JOBS) SHLIB_LIBS="-lncursesw" -C $(BUILD_DIR)/readline-7.0
	@make -j$(CONFIG_PARALLEL_JOBS) SHLIB_LIBS="-lncurses" DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/readline-7.0
	@mv -v $(ROOTFS_DIR)/usr/lib/libreadline.so.* $(ROOTFS_DIR)/lib
	@mv -v $(ROOTFS_DIR)/usr/lib/libhistory.so.* $(ROOTFS_DIR)/lib
	@ln -sfv ../../lib/`readlink $(ROOTFS_DIR)/usr/lib/libreadline.so` $(ROOTFS_DIR)/usr/lib/libreadline.so
	@ln -sfv ../../lib/`readlink $(ROOTFS_DIR)/usr/lib/libhistory.so` $(ROOTFS_DIR)/usr/lib/libhistory.so
	@rm -rf $(BUILD_DIR)/readline-7.0
