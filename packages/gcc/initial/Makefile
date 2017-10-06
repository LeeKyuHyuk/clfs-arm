include $(SUPPORT_DIR)/functions.mk

NAME := gcc-initial
HOST_DEPENDENCIES := gmp mpfr mpc
SOURCE := $(SOURCES_DIR)/gcc-7.2.0.tar.xz
SOURCE_URL := http://ftpmirror.gnu.org/gnu/gcc/gcc-7.2.0/gcc-7.2.0.tar.xz
MD5 := ff370482573133a7fcdd96cd2f552292

ifneq ($(CONFIG_FPU),)
TARGET_GCC_CONFIG += --with-fpu=$(CONFIG_FPU)
endif

ifneq ($(CONFIG_FLOAT),)
TARGET_GCC_CONFIG += --with-float=$(CONFIG_FLOAT)
endif

ifneq ($(CONFIG_MODE),)
TARGET_GCC_CONFIG += --with-mode=$(CONFIG_MODE)
endif

toolchain:
	@$(STEP) "gcc 7.2.0 - initial"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@tar -Jxf $(SOURCE) -C $(BUILD_DIR) --exclude='libjava/*' --exclude='libgo/*' --exclude='gcc/testsuite/*' --exclude='libstdc++-v3/testsuite/*'
	@mkdir -p $(BUILD_DIR)/gcc-7.2.0/libstdc++-v3/testsuite/
	@echo "all:" > $(BUILD_DIR)/gcc-7.2.0/libstdc++-v3/testsuite/Makefile.in
	@echo "install:" >> $(BUILD_DIR)/gcc-7.2.0/libstdc++-v3/testsuite/Makefile.in
	@patch -Np1 -i $(PACKAGES_DIR)/gcc/arm-softfloat-libgcc.patch -d $(BUILD_DIR)/gcc-7.2.0
	@patch -Np1 -i $(PACKAGES_DIR)/gcc/cilk-fix-build-without-wchar.patch -d $(BUILD_DIR)/gcc-7.2.0
	@patch -Np1 -i $(PACKAGES_DIR)/gcc/microblaze-Revert.patch -d $(BUILD_DIR)/gcc-7.2.0
	@patch -Np1 -i $(PACKAGES_DIR)/gcc/remove-selftests.patch -d $(BUILD_DIR)/gcc-7.2.0
	@mkdir -v $(BUILD_DIR)/gcc-7.2.0/gcc-build
	@( cd $(BUILD_DIR)/gcc-7.2.0/gcc-build && \
	PKG_CONFIG="$(TOOLS_DIR)/bin/pkg-config" \
	PKG_CONFIG_SYSROOT_DIR="/" \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
	PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/lib/pkgconfig:$(TOOLS_DIR)/share/pkgconfig" \
	CPPFLAGS="-I$(TOOLS_DIR)/include" \
	CFLAGS="-O2 -I$(TOOLS_DIR)/include" \
	CXXFLAGS="-O2 -I$(TOOLS_DIR)/include" \
	LDFLAGS="-L$(TOOLS_DIR)/lib -Wl,-rpath,$(TOOLS_DIR)/lib" \
	CFLAGS_FOR_TARGET="-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -Os" \
	CXXFLAGS_FOR_TARGET="-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -Os" \
	CONFIG_SITE=/dev/null \
	AR="ar" \
	MAKEINFO=missing \
	$(BUILD_DIR)/gcc-7.2.0/configure \
	--prefix=$(TOOLS_DIR) \
	--sysconfdir=$(TOOLS_DIR)/etc \
	--localstatedir=$(TOOLS_DIR)/var \
	--disable-static \
	--target=$(CONFIG_TARGET) \
	--with-sysroot=$(SYSROOT_DIR) \
	--disable-__cxa_atexit \
	--with-gnu-ld \
	--disable-libssp \
	--disable-multilib \
	--with-pkgversion="$(CONFIG_PKG_VERSION)" \
	--with-bugurl="$(CONFIG_BUG_URL)" \
	--disable-libquadmath \
	--disable-libsanitizer \
	--enable-tls \
	--disable-libmudflap \
	--enable-threads \
	--with-gmp=$(TOOLS_DIR) \
	--with-mpc=$(TOOLS_DIR) \
	--with-mpfr=$(TOOLS_DIR) \
	--without-isl \
	--without-cloog \
	--disable-decimal-float \
	--with-abi="$(CONFIG_ABI)" \
	--with-cpu=$(CONFIG_CPU) \
	$(TARGET_GCC_CONFIG) \
	--enable-languages=c \
	--disable-shared \
	--without-headers \
	--disable-threads \
	--with-newlib \
	--disable-largefile \
	--disable-nls )
	@make -j$(CONFIG_PARALLEL_JOBS) gcc_cv_libc_provides_ssp=yes all-gcc all-target-libgcc -C $(BUILD_DIR)/gcc-7.2.0/gcc-build
	@make -j$(CONFIG_PARALLEL_JOBS) install-gcc install-target-libgcc -C $(BUILD_DIR)/gcc-7.2.0/gcc-build
	@rm -rf $(BUILD_DIR)/gcc-7.2.0
	@echo $(NAME) >> $(TOOLCHAIN_DEPENDENCIES)
