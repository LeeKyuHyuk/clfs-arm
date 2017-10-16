include $(SUPPORT_DIR)/functions.mk

NAME := webkitgtk
TARGET_DEPENDENCIES := cairo enchant gst-plugins-base gst-plugins-bad libgtk2 libgtk3 icu libgudev libsecret libsoup mesa sqlite hicolor-icon-theme libnotify harfbuzz libwebp
SOURCE := $(SOURCES_DIR)/webkitgtk-2.18.0.tar.xz
SOURCE_URL := https://webkitgtk.org/releases/webkitgtk-2.18.0.tar.xz
MD5 := 10d86dd5a5b68875654cc38af139f382

ifeq ($(CONFIG_LINUX_ARCH),arm)
 JIT_OPTION = -DENABLE_JIT=ON
 GLES2_OPTION = -DENABLE_GLES2=OFF
endif

ifeq ($(CONFIG_LINUX_ARCH),arm64)
 JIT_OPTION = -DENABLE_JIT=OFF
 GLES2_OPTION = -DENABLE_GLES2=ON
endif

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "webkitgtk 2.18.0"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -i '/Activity.h/s:WebCore/:&platform/:' $(BUILD_DIR)/webkitgtk-2.18.0/Source/WebCore/platform/graphics/cairo/BackingStoreBackendCairoImpl.h
	@sed -e 's#enchant_dict_free_suggestions#enchant_dict_free_string_list#g' -i $(BUILD_DIR)/webkitgtk-2.18.0/Source/WebCore/platform/text/enchant/TextCheckerEnchant.cpp
	@mkdir -p $(BUILD_DIR)/webkitgtk-2.18.0/build
	@( cd $(BUILD_DIR)/webkitgtk-2.18.0/build && \
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
	$(JIT_OPTION) \
	-DENABLE_API_TESTS=OFF \
	-DENABLE_GEOLOCATION=OFF \
	-DENABLE_GTKDOC=OFF \
	-DENABLE_INTROSPECTION=OFF \
	-DENABLE_MINIBROWSER=OFF \
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
	$(GLES2_OPTION) \
	-DENABLE_OPENGL=ON \
	-Wno-dev ..  )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/webkitgtk-2.18.0/build
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/webkitgtk-2.18.0/build
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/webkitgtk-2.18.0/build
	@rm -rf $(BUILD_DIR)/webkitgtk-2.18.0
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
