include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/qt-everywhere-opensource-src-5.9.1.tar.xz
SOURCE_URL := http://ftp.jaist.ac.jp/pub/qtproject/archive/qt/5.9/5.9.1/single/qt-everywhere-opensource-src-5.9.1.tar.xz
MD5 := 77b4af61c49a09833d4df824c806acaf

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "QT 5.9.1 Base"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/qt5base/0001-Fix-error-attribute-target-crc-is-unknown.patch -d $(BUILD_DIR)/qt-everywhere-opensource-src-5.9.1/qtbase
	@install -m 0644 -Dv $(PACKAGES_DIR)/qt5base/qmake.conf $(BUILD_DIR)/qt-everywhere-opensource-src-5.9.1/qtbase/mkspecs/devices/linux-clfs-arm-g++/qmake.conf
	@install -m 0644 -Dv $(PACKAGES_DIR)/qt5base/qplatformdefs.h $(BUILD_DIR)/qt-everywhere-opensource-src-5.9.1/qtbase/mkspecs/devices/linux-clfs-arm-g++/qplatformdefs.h
	@echo "LIBS += -latomic" > $(BUILD_DIR)/qt-everywhere-opensource-src-5.9.1/qtbase/mkspecs/devices/linux-clfs-arm-g++/arch.conf
	@if ! grep -q 'EGL_DISPMANX_WINDOW_T' $(SYSROOT_DIR)/usr/include/EGL/eglplatform.h ; then \
		cp -v $(PACKAGES_DIR)/qt5base/eglplatform.h $(SYSROOT_DIR)/usr/include/EGL/eglplatform.h ; \
	fi;
	@( cd $(BUILD_DIR)/qt-everywhere-opensource-src-5.9.1 && \
	PKG_CONFIG_LIBDIR="$(SYSROOT_DIR)/usr/lib/pkgconfig" \
	PKG_CONFIG_SYSROOT_DIR="$(SYSROOT_DIR)" \
	MAKEFLAGS=" -j$(CONFIG_PARALLEL_JOBS)" \
	./configure -v \
	-release \
	-prefix /usr \
	-hostprefix $(TOOLS_DIR)/usr \
	-headerdir /usr/include/qt5 \
	-sysroot $(SYSROOT_DIR) \
	-plugindir /usr/lib/qt/plugins \
	-nomake examples \
	-nomake tests \
	-no-rpath \
	-device linux-clfs-arm-g++ \
	-device-option CROSS_COMPILE="$(TOOLS_DIR)/usr/bin/arm-linux-gnueabihf-" \
	-device-option BR_COMPILER_CFLAGS="-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -mfpu=$(CONFIG_FPU) -mtune=$(CONFIG_CPU) -mabi=$(CONFIG_ABI)" \
	-device-option BR_COMPILER_CXXFLAGS="-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -O2 -mfpu=$(CONFIG_FPU) -mtune=$(CONFIG_CPU) -mabi=$(CONFIG_ABI)" \
	-confirm-license \
	-opensource \
	-opengl es2 \
	-dbus-linked \
	-openssl-linked \
	-system-harfbuzz \
	-system-sqlite \
	-skip qt3d \
	-skip qtactiveqt \
	-skip qtandroidextras \
	-skip qtcanvas3d \
	-skip qtcharts \
	-skip qtconnectivity \
	-skip qtdatavis3d \
	-skip qtdoc \
	-skip qtgamepad \
	-skip qtgraphicaleffects \
	-skip qtimageformats \
	-skip qtlocation \
	-skip qtmacextras \
	-skip qtmultimedia \
	-skip qtnetworkauth \
	-skip qtpurchasing \
	-skip qtremoteobjects \
	-skip qtscript \
	-skip qtscxml \
	-skip qtsensors \
	-skip qtspeech \
	-skip qttranslations \
	-skip qtvirtualkeyboard \
	-skip qtwayland )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/qt-everywhere-opensource-src-5.9.1
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/qt-everywhere-opensource-src-5.9.1
	@cp -v $(PACKAGES_DIR)/qt5base/eglplatform.h.orig $(SYSROOT_DIR)/usr/include/EGL/eglplatform.h
	@rm -rf $(BUILD_DIR)/qt-everywhere-opensource-src-5.9.1

system:
	@$(STEP) "QT 5.9.1 Base"
	@cp -dpfv $(SYSROOT_DIR)/usr/lib/libQt5*.so.* $(ROOTFS_DIR)/usr/lib || exit 1 ; \
	@if [ -d $(SYSROOT_DIR)/usr/lib/qt/plugins/ ] ; then \
		mkdir -p $(ROOTFS_DIR)/usr/lib/qt/plugins ; \
		cp -dpfvr $(SYSROOT_DIR)/usr/lib/qt/plugins/* $(ROOTFS_DIR)/usr/lib/qt/plugins ; \
	fi
	@if [ -d $(SYSROOT_DIR)/usr/lib/qt/examples/ ] ; then \
		mkdir -p $(ROOTFS_DIR)/usr/lib/qt/examples ; \
		cp -dpfr $(SYSROOT_DIR)/usr/lib/qt/examples/* $(ROOTFS_DIR)/usr/lib/qt/examples ; \
	fi
