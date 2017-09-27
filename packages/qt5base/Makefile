include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/qt-everywhere-opensource-src-5.9.1.tar.xz
SOURCE_URL := http://ftp.jaist.ac.jp/pub/qtproject/archive/qt/5.9/5.9.1/single/qt-everywhere-opensource-src-5.9.1.tar.xz
MD5 := 77b4af61c49a09833d4df824c806acaf

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "QT 5.9.1 Base"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/qt5base/Fix-error-attribute-target-crc-is-unknown.patch -d $(BUILD_DIR)/qt-everywhere-opensource-src-5.9.1/qtbase
	@install -m 0644 -Dv $(PACKAGES_DIR)/qt5base/qmake.conf $(BUILD_DIR)/qt-everywhere-opensource-src-5.9.1/qtbase/mkspecs/devices/linux-clfs-arm-g++/qmake.conf
	@install -m 0644 -Dv $(PACKAGES_DIR)/qt5base/qplatformdefs.h $(BUILD_DIR)/qt-everywhere-opensource-src-5.9.1/qtbase/mkspecs/devices/linux-clfs-arm-g++/qplatformdefs.h
	@echo "LIBS += -latomic" > $(BUILD_DIR)/qt-everywhere-opensource-src-5.9.1/qtbase/mkspecs/devices/linux-clfs-arm-g++/arch.conf
	@( cd $(BUILD_DIR)/qt-everywhere-opensource-src-5.9.1 && \
	PKG_CONFIG="$(TOOLS_DIR)/bin/pkg-config" \
	PKG_CONFIG_LIBDIR="$(SYSROOT_DIR)/usr/lib/pkgconfig" \
	PKG_CONFIG_SYSROOT_DIR="$(SYSROOT_DIR)" \
	MAKEFLAGS=" -j$(CONFIG_PARALLEL_JOBS)" \
	./configure -v \
	-prefix /usr \
	-hostprefix $(TOOLS_DIR) \
	-headerdir /usr/include/qt5 \
	-sysroot $(SYSROOT_DIR) \
	-plugindir /usr/lib/qt/plugins \
	-examplesdir /usr/lib/qt/examples \
	-no-rpath \
	-nomake tests \
	-device linux-clfs-arm-g++ \
	-device-option CROSS_COMPILE="$(TOOLS_DIR)/bin/arm-linux-gnueabihf-" \
	-optimized-qmake \
	-no-cups \
	-no-iconv \
	-system-zlib \
	-system-pcre \
	-no-pch \
	-shared \
	-kms \
	-gbm \
	-release \
	-opensource \
	-confirm-license \
	-no-sql-mysql \
	-no-sql-psql \
	-system-sqlite \
	-gui \
	-system-freetype \
	-widgets \
	-no-linuxfb \
	-no-directfb \
	-xcb \
	-system-xkbcommon \
	-opengl es2 \
	-eglfs \
	--enable-linuxfb \
	-openssl \
	-fontconfig \
	-system-libjpeg \
	-system-libpng \
	-dbus \
	-no-tslib \
	-no-glib \
	-nomake examples \
	-libinput )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/qt-everywhere-opensource-src-5.9.1
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/qt-everywhere-opensource-src-5.9.1
	@$(call dependency_libs_patch)
	@cp -dpfv $(SYSROOT_DIR)/usr/lib/libQt5*.so.* $(ROOTFS_DIR)/usr/lib || exit 1 ; \
	@if [ -d $(SYSROOT_DIR)/usr/lib/qt/plugins/ ] ; then \
		mkdir -p $(ROOTFS_DIR)/usr/lib/qt/plugins ; \
		cp -dpfvr $(SYSROOT_DIR)/usr/lib/qt/plugins/* $(ROOTFS_DIR)/usr/lib/qt/plugins ; \
	fi
	@if [ -d $(SYSROOT_DIR)/usr/lib/qt/examples/ ] ; then \
		mkdir -p $(ROOTFS_DIR)/usr/lib/qt/examples ; \
		cp -dpfr $(SYSROOT_DIR)/usr/lib/qt/examples/* $(ROOTFS_DIR)/usr/lib/qt/examples ; \
	fi
	@rm -rf $(BUILD_DIR)/qt-everywhere-opensource-src-5.9.1
