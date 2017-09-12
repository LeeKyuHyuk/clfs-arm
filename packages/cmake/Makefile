include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/cmake-3.9.1.tar.gz
SOURCE_URL := https://cmake.org/files/v3.9/cmake-3.9.1.tar.gz
MD5 := 00f43c6a56d4903436317c14f9ca7f37

toolchain:
	@$(STEP) "cmake 3.9.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -i '/CMAKE_USE_LIBUV 1/s/1/0/' $(BUILD_DIR)/cmake-3.9.1/CMakeLists.txt
	@sed -i '/"lib64"/s/64//' $(BUILD_DIR)/cmake-3.9.1/Modules/GNUInstallDirs.cmake
	@( cd $(BUILD_DIR)/cmake-3.9.1 && \
	PKG_CONFIG="$(TOOLS_DIR)/bin/pkg-config" \
	PKG_CONFIG_SYSROOT_DIR="/" \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
	PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/lib/pkgconfig:$(TOOLS_DIR)/share/pkgconfig" \
	CPPFLAGS="-I$(TOOLS_DIR)/include" \
	CFLAGS="-O2 -I$(TOOLS_DIR)/include" \
	CXXFLAGS="-O2 -I$(TOOLS_DIR)/include" \
	LDFLAGS="-L$(TOOLS_DIR)/lib -Wl,-rpath,$(TOOLS_DIR)/lib" \
	CONFIG_SITE=/dev/null \
	./configure \
	--prefix=$(TOOLS_DIR) \
	--system-libs \
	--no-system-jsoncpp \
	--no-system-librhash )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/cmake-3.9.1
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/cmake-3.9.1
	@mkdir -pv $(TOOLS_DIR)/share/clfs-arm
	@cp -Rv $(SUPPORT_DIR)/cmake/* $(TOOLS_DIR)/share/clfs-arm/
	@rm -rf $(BUILD_DIR)/cmake-3.9.1
