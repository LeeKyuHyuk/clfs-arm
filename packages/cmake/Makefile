include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/cmake-3.8.2.tar.gz
SOURCE_URL := http://www.cmake.org/files/v3.8/cmake-3.8.2.tar.gz
MD5 := b5dff61f6a7f1305271ab3f6ae261419

toolchain:
	@$(STEP) "cmake 3.8.2"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -i '/CMAKE_USE_LIBUV 1/s/1/0/' $(BUILD_DIR)/cmake-3.8.2/CMakeLists.txt
	@sed -i '/"lib64"/s/64//' $(BUILD_DIR)/cmake-3.8.2/Modules/GNUInstallDirs.cmake
	@( cd $(BUILD_DIR)/cmake-3.8.2 && \
	CFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
	CPPFLAGS="-I$(TOOLS_DIR)/usr/include" \
	CXXFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
	LDFLAGS="-L$(TOOLS_DIR)/lib -L$(TOOLS_DIR)/usr/lib -Wl,-rpath,$(TOOLS_DIR)/usr/lib" \
	PKG_CONFIG="$(TOOLS_DIR)/usr/bin/pkg-config" \
	PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/usr/lib/pkgconfig:$(TOOLS_DIR)/usr/share/pkgconfig" \
	PKG_CONFIG_SYSROOT_DIR="/" \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
	./bootstrap \
	--prefix=$(TOOLS_DIR)/usr \
	--system-libs \
	--no-system-jsoncpp  \
	--no-system-librhash )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/cmake-3.8.2
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/cmake-3.8.2
	@rm -rf $(BUILD_DIR)/cmake-3.8.2
