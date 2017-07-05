include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/libffi-3.2.1.tar.gz
SOURCE_URL := ftp://sourceware.org/pub/libffi/libffi-3.2.1.tar.gz
MD5 := 83b89587607e3eb65c70d361f13bab43

toolchain:
	@$(STEP) "libffi 3.2.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -i -e 's/toolexeclib_LTLIBRARIES = libffi.la/lib_LTLIBRARIES = libffi.la/g' $(BUILD_DIR)/libffi-3.2.1/Makefile.am
	@( cd $(BUILD_DIR)/libffi-3.2.1 && \
	CFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
	CPPFLAGS="-I$(TOOLS_DIR)/usr/include" \
	CXXFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
	LDFLAGS="-L$(TOOLS_DIR)/lib -L$(TOOLS_DIR)/usr/lib -Wl,-rpath,$(TOOLS_DIR)/usr/lib" \
	PKG_CONFIG="$(TOOLS_DIR)/usr/bin/pkg-config" \
	PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/usr/lib/pkgconfig:$(TOOLS_DIR)/usr/share/pkgconfig" \
	PKG_CONFIG_SYSROOT_DIR="/" \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
	./configure \
	--prefix=$(TOOLS_DIR)/usr \
	--sysconfdir=$(TOOLS_DIR)/etc \
	--localstatedir=$(TOOLS_DIR)/var \
	--enable-shared \
	--disable-static )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/libffi-3.2.1
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/libffi-3.2.1
	@mv $(TOOLS_DIR)/usr/lib/libffi-3.2.1/include/*.h $(TOOLS_DIR)/usr/include/
	@sed -i -e '/^includedir.*/d' -e '/^Cflags:.*/d' $(TOOLS_DIR)/usr/lib/pkgconfig/libffi.pc
	@rm -rf $(TOOLS_DIR)/usr/lib/libffi-*
	@rm -rf $(BUILD_DIR)/libffi-3.2.1

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "libffi 3.2.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/libffi-3.2.1 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--disable-static )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/libffi-3.2.1
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/libffi-3.2.1
	@mv -v $(SYSROOT_DIR)/usr/lib/libffi-3.2.1/include/*.h $(SYSROOT_DIR)/usr/include/
	@sed -i -e '/^includedir.*/d' -e '/^Cflags:.*/d' $(SYSROOT_DIR)/usr/lib/pkgconfig/libffi.pc
	@rm -rf $(BUILD_DIR)/libffi-3.2.1

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "libffi 3.2.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/libffi-3.2.1 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--disable-static )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/libffi-3.2.1
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/libffi-3.2.1
	@mv $(ROOTFS_DIR)/usr/lib/libffi-3.2.1/include/*.h $(ROOTFS_DIR)/usr/include/
	@sed -i -e '/^includedir.*/d' -e '/^Cflags:.*/d' $(ROOTFS_DIR)/usr/lib/pkgconfig/libffi.pc
	@rm -rf $(BUILD_DIR)/libffi-3.2.1
