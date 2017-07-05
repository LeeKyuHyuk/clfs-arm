include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/kmod-24.tar.xz
SOURCE_URL := https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-24.tar.xz
MD5 := 08297dfb6f2b3f625f928ca3278528af

toolchain:
	@$(STEP) "kmod 24"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/kmod-24 && \
	CFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
	CPPFLAGS="-I$(TOOLS_DIR)/usr/include" \
	CXXFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
	LDFLAGS="-L$(TOOLS_DIR)/lib -L$(TOOLS_DIR)/usr/lib -Wl,-rpath,$(TOOLS_DIR)/usr/lib" \
	PKG_CONFIG="$(TOOLS_DIR)/usr/bin/pkg-config" \
	PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/usr/lib/pkgconfig:$(TOOLS_DIR)/usr/share/pkgconfig" \
	./configure \
	--prefix=$(TOOLS_DIR)/usr \
	--sysconfdir=$(TOOLS_DIR)/etc \
	--localstatedir=$(TOOLS_DIR)/var \
	--disable-manpages )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/kmod-24
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/kmod-24
	@mkdir -p $(TOOLS_DIR)/sbin/
	@ln -svf ../usr/bin/kmod $(TOOLS_DIR)/sbin/depmod
	@rm -rf $(BUILD_DIR)/kmod-24

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "kmod 24"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/kmod-24 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--bindir=/bin \
	--sysconfdir=/etc \
	--with-rootlibdir=/lib \
	--with-xz \
	--with-zlib )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/kmod-24
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/kmod-24
	@for target in depmod insmod lsmod modinfo modprobe rmmod ; do \
  	ln -svf ../bin/kmod $(ROOTFS_DIR)/sbin/$${target} ; \
	done
	@ln -svf kmod $(ROOTFS_DIR)/bin/lsmod
	@rm -rf $(BUILD_DIR)/kmod-24
