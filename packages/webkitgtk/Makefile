include $(SUPPORT_DIR)/functions.mk

NAME := webkitgtk
TARGET_DEPENDENCIES := cairo enchant gst-plugins-base libgtk2 libgtk3 icu libgudev libsecret libsoup mesa sqlite hicolor-icon-theme libnotify harfbuzz libwebp
SOURCE := $(SOURCES_DIR)/webkitgtk-2.16.6.tar.xz
SOURCE_URL := https://webkitgtk.org/releases/webkitgtk-2.16.6.tar.xz
MD5 := 0e2d142a586e4ff79cf0324f4fdbf20c

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "webkitgtk 2.16.6"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -i 's/unsigned short/char16_t/' $(BUILD_DIR)/webkitgtk-2.16.6/Source/JavaScriptCore/API/JSStringRef.h $(BUILD_DIR)/webkitgtk-2.16.6/Source/WebKit2/Shared/API/c/WKString.h
	@sed -i '/stdbool.h/ a#include <uchar.h>' $(BUILD_DIR)/webkitgtk-2.16.6/Source/JavaScriptCore/API/JSBase.h
	@mkdir -p $(BUILD_DIR)/webkitgtk-2.16.6/build
	@( cd $(BUILD_DIR)/webkitgtk-2.16.6/build && \
	PKG_CONFIG="$(TOOLS_DIR)/bin/pkg-config" \
	ac_cv_lbl_unaligned_fail=yes \
	ac_cv_func_mmap_fixed_mapped=yes \
	ac_cv_func_memcmp_working=yes \
	ac_cv_have_decl_malloc=yes \
	gl_cv_func_malloc_0_nonnull=yes \
	ac_cv_func_malloc_0_nonnull=yes \
	ac_cv_func_calloc_0_nonnull=yes \
	ac_cv_func_realloc_0_nonnull=yes \
	lt_cv_sys_lib_search_path_spec="" \
	ac_cv_c_bigendian=no \
	CONFIG_SITE=/dev/null \
	CFLAGS="-Wno-expansion-to-defined -fpermissive" \
	CXXFLAGS="-Wno-expansion-to-defined -fpermissive" \
	cmake -DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_TOOLCHAIN_FILE=$(TOOLS_DIR)/share/clfs-arm/toolchainfile.cmake \
	-DENABLE_JIT=ON \
	-DENABLE_API_TESTS=OFF \
	-DENABLE_GEOLOCATION=OFF \
	-DENABLE_GTKDOC=OFF \
	-DENABLE_INTROSPECTION=OFF \
	-DENABLE_MINIBROWSER=ON \
	-DENABLE_SPELLCHECK=ON \
	-DPORT=GTK \
	-DUSE_LIBSECRET=ON \
	-DUSE_LIBNOTIFY=ON \
	-DUSE_LIBHYPHEN=OFF \
	-DCMAKE_INSTALL_PREFIX=/usr \
	-DCMAKE_SKIP_RPATH=ON \
	-DLIB_INSTALL_DIR=/usr/lib \
	-DENABLE_OPENGL=ON \
	-DENABLE_X11_TARGET=ON \
	-DENABLE_VIDEO=ON \
	-DENABLE_WEB_AUDIO=ON \
	-DENABLE_GLES2=ON \
	-DENABLE_OPENGL=ON \
	-Wno-dev ..  )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/webkitgtk-2.16.6/build
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/webkitgtk-2.16.6/build
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/webkitgtk-2.16.6/build
	@rm -rf $(BUILD_DIR)/webkitgtk-2.16.6
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
