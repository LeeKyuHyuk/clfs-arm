include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/webkitgtk-2.16.6.tar.xz
SOURCE_URL := https://webkitgtk.org/releases/webkitgtk-2.16.6.tar.xz
MD5 := 0e2d142a586e4ff79cf0324f4fdbf20c

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "webkitgtk 2.16.6"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -i 's/unsigned short/char16_t/' $(BUILD_DIR)/webkitgtk-2.16.6/Source/JavaScriptCore/API/JSStringRef.h $(BUILD_DIR)/webkitgtk-2.16.6/Source/WebKit2/Shared/API/c/WKString.h
	@sed -i '/stdbool.h/ a#include <uchar.h>' $(BUILD_DIR)/webkitgtk-2.16.6/Source/JavaScriptCore/API/JSBase.h
	@mkdir -p $(BUILD_DIR)/webkitgtk-2.16.6/build
	@( cd $(BUILD_DIR)/webkitgtk-2.16.6/build && \
	PKG_CONFIG="$(TOOLS_DIR)/usr/bin/pkg-config" \
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
	-DUSE_LIBNOTIFY=OFF \
	-DUSE_LIBHYPHEN=OFF \
	-DCMAKE_INSTALL_PREFIX=/usr \
	-DCMAKE_SKIP_RPATH=ON \
	-DLIB_INSTALL_DIR=/usr/lib \
	-DENABLE_GLES2=ON \
	-DENABLE_OPENGL=ON \
	-DENABLE_X11_TARGET=OFF \
	-DENABLE_WAYLAND_TARGET=ON \
	-Wno-dev ..  )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/webkitgtk-2.16.6/build
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/webkitgtk-2.16.6/build
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/webkitgtk-2.16.6/build
	@rm -rf $(BUILD_DIR)/webkitgtk-2.16.6
