include $(SUPPORT_DIR)/functions.mk

GCC_SOURCE := $(SOURCES_DIR)/gcc-6.3.0.tar.bz2
MPFR_SOURCE := $(SOURCES_DIR)/mpfr-3.1.5.tar.xz
GMP_SOURCE := $(SOURCES_DIR)/gmp-6.1.2.tar.xz
MPC_SOURCE := $(SOURCES_DIR)/mpc-1.0.3.tar.gz

GCC_SOURCE_URL := http://ftp.gnu.org/gnu/gcc/gcc-6.3.0/gcc-6.3.0.tar.bz2
MPFR_SOURCE_URL := http://www.mpfr.org/mpfr-3.1.5/mpfr-3.1.5.tar.xz
GMP_SOURCE_URL := http://ftp.gnu.org/gnu/gmp/gmp-6.1.2.tar.xz
MPC_SOURCE_URL := https://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz

GCC_MD5 := 677a7623c7ef6ab99881bc4e048debb6
MPFR_MD5 := c4ac246cf9795a4491e7766002cd528f
GMP_MD5 := f58fa8001d60c4c77595fbbb62b63c1d
MPC_MD5 := d6a1d5f8ddea3abd2cc3e98f58352d26

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "gcc 6.3.0"
	@$(call check_source, $(GCC_SOURCE), $(GCC_MD5), $(GCC_SOURCE_URL))
	@$(EXTRACT) $(GCC_SOURCE) $(BUILD_DIR)
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
	$(BUILD_DIR)/gcc-6.3.0/configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=$(SYSROOT_DIR)/usr \
	--disable-decimal-float \
	--with-abi="$(CONFIG_ABI)" \
	--with-cpu=$(CONFIG_CPU) \
	--with-fpu=$(CONFIG_FPU) \
	--with-float=$(CONFIG_FLOAT) \
	--with-mode=$(CONFIG_MODE) \
	--enable-languages=c,c++ \
	--disable-multilib \
	--disable-bootstrap \
	--with-system-zlib )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/gcc-6.3.0/gcc-build
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/gcc-6.3.0/gcc-build
	@rm -rf $(BUILD_DIR)/gcc-6.3.0

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "gcc 6.3.0"
	@$(call check_source, $(GCC_SOURCE), $(GCC_MD5), $(GCC_SOURCE_URL))
	@$(EXTRACT) $(GCC_SOURCE) $(BUILD_DIR)
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
	$(BUILD_DIR)/gcc-6.3.0/configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--disable-decimal-float \
	--with-abi="$(CONFIG_ABI)" \
	--with-cpu=$(CONFIG_CPU) \
	--with-fpu=$(CONFIG_FPU) \
	--with-float=$(CONFIG_FLOAT) \
	--with-mode=$(CONFIG_MODE) \
	--enable-languages=c,c++ \
	--disable-multilib \
	--disable-bootstrap \
	--with-system-zlib )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/gcc-6.3.0/gcc-build
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/gcc-6.3.0/gcc-build
	@ln -svf ../usr/bin/cpp $(ROOTFS_DIR)/lib
	@ln -svf gcc $(ROOTFS_DIR)/usr/bin/cc
	@mkdir -pv $(ROOTFS_DIR)/usr/share/gdb/auto-load/usr/lib
	@mv -v $(ROOTFS_DIR)/usr/lib/*gdb.py $(ROOTFS_DIR)/usr/share/gdb/auto-load/usr/lib
	@rm -rf $(BUILD_DIR)/gcc-6.3.0
