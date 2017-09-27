include $(SUPPORT_DIR)/functions.mk

SOURCE := $(PACKAGES_DIR)/tint2/tint2-15.1-63c3690fa8efb1cd2dd23969f219f9b7a37a65b6.tar.bz2
SOURCE_URL := https://gitlab.com/o9000/tint2/repository/15.1/archive.tar.bz2
MD5 := 8a01e325fbe68bd23dd2f8d7514cbca5

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "tint2 15.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@mkdir -p $(BUILD_DIR)/tint2-15.1-63c3690fa8efb1cd2dd23969f219f9b7a37a65b6/build
	@( cd $(BUILD_DIR)/tint2-15.1-63c3690fa8efb1cd2dd23969f219f9b7a37a65b6/build && \
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
	-Wno-dev ..  )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/tint2-15.1-63c3690fa8efb1cd2dd23969f219f9b7a37a65b6/build
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/tint2-15.1-63c3690fa8efb1cd2dd23969f219f9b7a37a65b6/build
	@rm -rf $(BUILD_DIR)/tint2-15.1-63c3690fa8efb1cd2dd23969f219f9b7a37a65b6
