include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/bzip2-1.0.6.tar.gz
SOURCE_URL := http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz
MD5 := 00b516f4704d4a7cb50a1d97e6e8e15b

toolchain:
	@$(STEP) "bzip2 1.0.6"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/bzip2/bzip2-1.0.6-install_docs-1.patch -d $(BUILD_DIR)/bzip2-1.0.6
	@sed -i 's#\(ln -s -f \)$(PREFIX)/bin/#\1#' $(BUILD_DIR)/bzip2-1.0.6/Makefile
	@sed -i "s#(PREFIX)/share/man#(PREFIX)/share/man#g" $(BUILD_DIR)/bzip2-1.0.6/Makefile
	@sed -i "s#bzip2recover test#bzip2recover#g" $(BUILD_DIR)/bzip2-1.0.6/Makefile
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/bzip2-1.0.6 -f Makefile-libbz2_so
	@make clean -C $(BUILD_DIR)/bzip2-1.0.6
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/bzip2-1.0.6
	@make -j$(CONFIG_PARALLEL_JOBS) PREFIX=$(TOOLS_DIR) install -C $(BUILD_DIR)/bzip2-1.0.6
	@rm -rf $(BUILD_DIR)/bzip2-1.0.6

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "bzip2 1.0.6"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/bzip2/bzip2-1.0.6-install_docs-1.patch -d $(BUILD_DIR)/bzip2-1.0.6
	@sed -i 's#\(ln -s -f \)$(PREFIX)/bin/#\1#' $(BUILD_DIR)/bzip2-1.0.6/Makefile
	@sed -i "s#(PREFIX)/share/man#(PREFIX)/share/man#g" $(BUILD_DIR)/bzip2-1.0.6/Makefile
	@sed -i "s#bzip2recover test#bzip2recover#g" $(BUILD_DIR)/bzip2-1.0.6/Makefile
	@make -j$(CONFIG_PARALLEL_JOBS) CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib CFLAGS="-fPIC" CXXFLAGS="-fPIC" -C $(BUILD_DIR)/bzip2-1.0.6 -f Makefile-libbz2_so
	@make clean -C $(BUILD_DIR)/bzip2-1.0.6
	@make -j$(CONFIG_PARALLEL_JOBS) CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib CFLAGS="-fPIC" CXXFLAGS="-fPIC" -C $(BUILD_DIR)/bzip2-1.0.6
	@make -j$(CONFIG_PARALLEL_JOBS) CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib CFLAGS="-fPIC" CXXFLAGS="-fPIC" PREFIX=$(SYSROOT_DIR)/usr install -C $(BUILD_DIR)/bzip2-1.0.6
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib CFLAGS="-fPIC" CXXFLAGS="-fPIC" PREFIX=$(ROOTFS_DIR)/usr install -C $(BUILD_DIR)/bzip2-1.0.6
	@cp -v $(BUILD_DIR)/bzip2-1.0.6/bzip2-shared $(ROOTFS_DIR)/bin/bzip2
	@cp -av $(BUILD_DIR)/bzip2-1.0.6/libbz2.so* $(ROOTFS_DIR)/lib
	@ln -sfv ../../lib/libbz2.so.1.0 $(ROOTFS_DIR)/usr/lib/libbz2.so
	@rm -v $(ROOTFS_DIR)/usr/bin/bunzip2
	@rm -v $(ROOTFS_DIR)/usr/bin/bzcat
	@rm -v $(ROOTFS_DIR)/usr/bin/bzip2
	@ln -sfv bzip2 $(ROOTFS_DIR)/bin/bunzip2
	@ln -sfv bzip2 $(ROOTFS_DIR)/bin/bzcat
	@rm -rf $(BUILD_DIR)/bzip2-1.0.6
