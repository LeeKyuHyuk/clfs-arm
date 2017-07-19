include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/nasm-2.12.02.tar.xz
SOURCE_URL := http://www.nasm.us/pub/nasm/releasebuilds/2.12.02/nasm-2.12.02.tar.xz
MD5 := b90a3d85b93e51a7fa5a67e2a8fccfef

toolchain:
	@$(STEP) "nasm 2.12.02"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/nasm-2.12.02 && \
	CFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
	CPPFLAGS="-I$(TOOLS_DIR)/usr/include" \
	CXXFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
	LDFLAGS="-L$(TOOLS_DIR)/lib -L$(TOOLS_DIR)/usr/lib -Wl,-rpath,$(TOOLS_DIR)/usr/lib" \
	PKG_CONFIG="$(TOOLS_DIR)/usr/bin/pkg-config" \
	PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/usr/lib/pkgconfig:$(TOOLS_DIR)/usr/share/pkgconfig" \
	PKG_CONFIG_SYSROOT_DIR="/" \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
	./configure \
	--prefix=$(TOOLS_DIR)/usr \
	--disable-static )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/nasm-2.12.02
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/nasm-2.12.02
	@rm -rf $(BUILD_DIR)/nasm-2.12.02

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "nasm 2.12.02"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/nasm-2.12.02 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/nasm-2.12.02
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/nasm-2.12.02
	@rm -rf $(BUILD_DIR)/nasm-2.12.02

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "nasm 2.12.02"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/nasm-2.12.02 && \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/nasm-2.12.02
	@make -j$(CONFIG_PARALLEL_JOBS) prefix=$(ROOTFS_DIR) install -C $(BUILD_DIR)/nasm-2.12.02
	@rm -rf $(BUILD_DIR)/nasm-2.12.02
