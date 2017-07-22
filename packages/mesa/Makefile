include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/mesa-17.1.5.tar.xz
SOURCE_URL := https://mesa.freedesktop.org/archive/mesa-17.1.5.tar.xz
MD5 := 6cf936fbcaadd98924298a7009e8265d

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "mesa 17.1.5"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/mesa/configure.ac-invert-order-for-wayland-scanner-check.patch -d $(BUILD_DIR)/mesa-17.1.5
	@sed -i "/pthread_stubs_possible=/s/yes/no/" $(BUILD_DIR)/mesa-17.1.5/configure.ac
	@( cd $(BUILD_DIR)/mesa-17.1.5 && \
	./autogen.sh \
	CFLAGS='-O2' \
	CXXFLAGS='-O2' \
	WAILAND_SCANNER=$(TOOLS_DIR)/usr/bin/wayland-scanner \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--libdir=$(SYSROOT_DIR)/usr/lib \
	--sysconfdir=$(SYSROOT_DIR)/etc \
	--enable-gles2 \
	--enable-gbm \
	--enable-shared-glapi \
	--with-platforms="drm,wayland,x11" \
	--with-gallium-drivers="swrast,vc4" )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/mesa-17.1.5
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/mesa-17.1.5
	@rm -rf $(BUILD_DIR)/mesa-17.1.5

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "mesa 17.1.5"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/mesa/configure.ac-invert-order-for-wayland-scanner-check.patch -d $(BUILD_DIR)/mesa-17.1.5
	@sed -i "/pthread_stubs_possible=/s/yes/no/" $(BUILD_DIR)/mesa-17.1.5/configure.ac
	@( cd $(BUILD_DIR)/mesa-17.1.5 && \
	./autogen.sh \
	CFLAGS='-O2' \
	CXXFLAGS='-O2' \
	WAILAND_SCANNER=$(TOOLS_DIR)/usr/bin/wayland-scanner \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--libdir=/usr/lib \
	--sysconfdir=/etc \
	--disable-libunwind \
	--enable-gles2 \
	--enable-gbm \
	--enable-shared-glapi \
	--with-platforms="drm,wayland,x11" \
	--with-gallium-drivers="swrast,vc4" )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/mesa-17.1.5
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/mesa-17.1.5
	@rm -rf $(BUILD_DIR)/mesa-17.1.5
