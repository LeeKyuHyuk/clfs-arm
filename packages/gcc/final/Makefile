include $(SUPPORT_DIR)/functions.mk

GCC_SOURCE := $(SOURCES_DIR)/gcc-6.3.0.tar.bz2
MPFR_SOURCE := $(SOURCES_DIR)/mpfr-3.1.5.tar.bz2
GMP_SOURCE := $(SOURCES_DIR)/gmp-6.1.2.tar.bz2
MPC_SOURCE := $(SOURCES_DIR)/mpc-1.0.3.tar.gz

GCC_SOURCE_URL := http://ftpmirror.gnu.org/gnu/gcc/gcc-6.3.0/gcc-6.3.0.tar.bz2
MPFR_SOURCE_URL := http://ftpmirror.gnu.org/gnu/mpfr/mpfr-3.1.5.tar.bz2
GMP_SOURCE_URL := http://ftpmirror.gnu.org/gnu/gmp/gmp-6.1.2.tar.bz2
MPC_SOURCE_URL := https://ftpmirror.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz

GCC_MD5 := 677a7623c7ef6ab99881bc4e048debb6
MPFR_MD5 := b1d23a55588e3b2a13e3be66bc69fd8d
GMP_MD5 := 8ddbb26dc3bd4e2302984debba1406a5
MPC_MD5 := d6a1d5f8ddea3abd2cc3e98f58352d26

toolchain:
	@$(STEP) "gcc 6.3.0 - final"
	@$(call check_source, $(GCC_SOURCE), $(GCC_MD5), $(GCC_SOURCE_URL))
	@tar -jxf $(SOURCES_DIR)/gcc-6.3.0.tar.bz2 -C $(BUILD_DIR) --exclude='libjava/*' --exclude='libgo/*' --exclude='gcc/testsuite/*' --exclude='libstdc++-v3/testsuite/*'
	@mkdir -p $(BUILD_DIR)/gcc-6.3.0/libstdc++-v3/testsuite/
	@echo "all:" > $(BUILD_DIR)/gcc-6.3.0/libstdc++-v3/testsuite/Makefile.in
	@echo "install:" >> $(BUILD_DIR)/gcc-6.3.0/libstdc++-v3/testsuite/Makefile.in
	@$(call check_source, $(MPFR_SOURCE), $(MPFR_MD5), $(MPFR_SOURCE_URL))
	@$(EXTRACT) $(MPFR_SOURCE) $(BUILD_DIR)/gcc-6.3.0
	@mv -v $(BUILD_DIR)/gcc-6.3.0/mpfr-3.1.5 $(BUILD_DIR)/gcc-6.3.0/mpfr
	@$(call check_source, $(GMP_SOURCE), $(GMP_MD5), $(GMP_SOURCE_URL))
	@$(EXTRACT) $(GMP_SOURCE) $(BUILD_DIR)/gcc-6.3.0
	@mv -v $(BUILD_DIR)/gcc-6.3.0/gmp-6.1.2 $(BUILD_DIR)/gcc-6.3.0/gmp
	@$(call check_source, $(MPC_SOURCE), $(MPC_MD5), $(MPC_SOURCE_URL))
	@$(EXTRACT) $(MPC_SOURCE) $(BUILD_DIR)/gcc-6.3.0
	@mv -v $(BUILD_DIR)/gcc-6.3.0/mpc-1.0.3 $(BUILD_DIR)/gcc-6.3.0/mpc
	@mkdir -v $(BUILD_DIR)/gcc-6.3.0/gcc-build
	@( cd $(BUILD_DIR)/gcc-6.3.0/gcc-build && \
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
	AR="ar" \
	$(BUILD_DIR)/gcc-6.3.0/configure \
	--prefix=$(TOOLS_DIR) \
	--sysconfdir=$(TOOLS_DIR)/etc \
	--enable-static \
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
	--without-isl \
	--without-cloog \
	--disable-decimal-float \
	--with-abi="$(CONFIG_ABI)" \
	--with-cpu=$(CONFIG_CPU) \
	--with-fpu=$(CONFIG_FPU) \
	--with-float=$(CONFIG_FLOAT) \
	--with-mode=$(CONFIG_MODE) \
	--enable-languages=c,c++ \
	--with-build-time-tools=$(TOOLS_DIR)/$(CONFIG_TARGET)/bin \
	--enable-shared \
	--disable-libgomp )
	@make -j$(CONFIG_PARALLEL_JOBS) AS_FOR_TARGET="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as" LD_FOR_TARGET="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld" gcc_cv_libc_provides_ssp=yes -C $(BUILD_DIR)/gcc-6.3.0/gcc-build
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/gcc-6.3.0/gcc-build
	if [ ! -e $(TOOLS_DIR)/bin/$(CONFIG_TARGET)-cc ]; then \
		ln -vf $(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc $(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-cc; \
	fi
	@rm -rf $(BUILD_DIR)/gcc-6.3.0
