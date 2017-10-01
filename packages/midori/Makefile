include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/midori_0.5.11_all_.tar.bz2
SOURCE_URL := http://www.midori-browser.org/downloads/midori_0.5.11_all_.tar.bz2
MD5 := fcc03ef759fce4fe9f2446d9da4a065e

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "Midori 0.5.11"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/midori/fix-bug-1492932.patch -d $(BUILD_DIR)/midori-0.5.11
	@patch -Np1 -i $(PACKAGES_DIR)/midori/gcr-for-x11-only.patch -d $(BUILD_DIR)/midori-0.5.11
	@mkdir -p $(BUILD_DIR)/midori-0.5.11/build
	@( cd $(BUILD_DIR)/midori-0.5.11/build && \
	cmake \
	-DCMAKE_TOOLCHAIN_FILE=$(TOOLS_DIR)/share/clfs-arm/toolchainfile.cmake \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX="/usr" \
	-DCMAKE_COLOR_MAKEFILE=OFF \
	-DBUILD_DOC=OFF \
	-DBUILD_DOCS=OFF \
	-DBUILD_EXAMPLE=OFF \
	-DBUILD_EXAMPLES=OFF \
	-DBUILD_TEST=OFF \
	-DBUILD_TESTS=OFF \
	-DBUILD_TESTING=OFF \
	-DBUILD_SHARED_LIBS=ON \
	-DHALF_BRO_INCOM_WEBKIT2=ON \
	-DUSE_GRANITE=ON \
	-DENABLE_JIT=ON \
	-DENABLE_INTROSPECTION=OFF \
	-DENABLE_MINIBROWSER=ON \
	-DENABLE_SPELLCHECK=ON \
	-DPORT=GTK \
	-DUSE_LIBNOTIFY=ON \
	-DUSE_LIBHYPHEN=OFF \
	-DUSE_GTK3=ON \
	-DUSE_ZEITGEIST=OFF \
	-DENABLE_GLES2=ON \
	-DENABLE_OPENGL=ON \
	-DENABLE_X11_TARGET=ON \
	-DENABLE_WAYLAND_TARGET=OFF \
	-Wno-dev ..  )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/midori-0.5.11/build
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install/fast -C $(BUILD_DIR)/midori-0.5.11/build
	@rm -rf $(BUILD_DIR)/midori-0.5.11
