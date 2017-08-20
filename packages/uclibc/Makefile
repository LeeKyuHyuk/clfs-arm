include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/uClibc-ng-1.0.26.tar.xz
SOURCE_URL := https://downloads.uclibc-ng.org/releases/1.0.26/uClibc-ng-1.0.26.tar.xz
MD5 := c81ece6daace7d38bb6a9d006f88e1f4

staging:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "uClibc-ng 1.0.26"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@make defconfig -C $(BUILD_DIR)/uClibc-ng-1.0.26
	@sed -i -e "/\\<CROSS_COMPILER_PREFIX\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'CROSS_COMPILER_PREFIX="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-"' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<TARGET_arm\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'TARGET_arm=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<TARGET_ARCH\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'TARGET_ARCH="arm"' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<KERNEL_HEADERS\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'KERNEL_HEADERS="$(SYSROOT_DIR)/usr/include"' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<RUNTIME_PREFIX\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'RUNTIME_PREFIX="/"' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<DEVEL_PREFIX\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'DEVEL_PREFIX="/usr"' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<SHARED_LIB_LOADER_PREFIX\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'SHARED_LIB_LOADER_PREFIX="/lib"' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<ARCH_HAS_MMU\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'ARCH_HAS_MMU=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<ARCH_USE_MMU\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'ARCH_USE_MMU=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e '/CONFIG_ARM_.ABI/d' $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<CONFIG_ARM_EABI\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'CONFIG_ARM_EABI=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<ARCH_LITTLE_ENDIAN\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'ARCH_LITTLE_ENDIAN=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<ARCH_WANTS_LITTLE_ENDIAN\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'ARCH_WANTS_LITTLE_ENDIAN=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<ARCH_BIG_ENDIAN\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo '# ARCH_BIG_ENDIAN is not set' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<ARCH_WANTS_BIG_ENDIAN\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo '# ARCH_WANTS_BIG_ENDIAN is not set' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<UCLIBC_HAS_IPV6\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'UCLIBC_HAS_IPV6=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<UCLIBC_HAS_FPU\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'UCLIBC_HAS_FPU=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<UCLIBC_HAS_FLOATS\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'UCLIBC_HAS_FLOATS=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<UCLIBC_HAS_SSP\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo '# UCLIBC_HAS_SSP is not set' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<UCLIBC_BUILD_SSP\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo '# UCLIBC_BUILD_SSP is not set' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<UCLIBC_HAS_THREADS\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'UCLIBC_HAS_THREADS=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<UCLIBC_HAS_LINUXTHREADS\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo '# UCLIBC_HAS_LINUXTHREADS is not set' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<UCLIBC_HAS_THREADS_NATIVE\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'UCLIBC_HAS_THREADS_NATIVE=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<PTHREADS_DEBUG_SUPPORT\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo '# PTHREADS_DEBUG_SUPPORT is not set' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<UCLIBC_HAS_LOCALE\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo '# UCLIBC_HAS_LOCALE is not set' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<UCLIBC_HAS_WCHAR\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'UCLIBC_HAS_WCHAR=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<HAVE_SHARED\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'HAVE_SHARED=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo '# UCLIBC_BUILD_PIE is not set' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/uClibc-ng-1.0.26 ARCH=$(CONFIG_MODE) CROSS_COMPILE=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)- UCLIBC_EXTRA_CFLAGS="" HOSTCC=gcc headers
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/uClibc-ng-1.0.26 ARCH=$(CONFIG_MODE) CROSS_COMPILE=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)- UCLIBC_EXTRA_CFLAGS="" HOSTCC=gcc
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/uClibc-ng-1.0.26/utils PREFIX=$(TOOLS_DIR) HOSTCC="gcc" hostutils
	@make -j1 -C $(BUILD_DIR)/uClibc-ng-1.0.26 ARCH=$(CONFIG_MODE) CROSS_COMPILE=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)- UCLIBC_EXTRA_CFLAGS="" HOSTCC=gcc PREFIX=$(SYSROOT_DIR) DEVEL_PREFIX=/usr/ RUNTIME_PREFIX=/ install_runtime install_dev
	@install -Dv -m 0755 $(BUILD_DIR)/uClibc-ng-1.0.26/utils/ldd.host $(TOOLS_DIR)/bin/ldd
	@ln -sf ldd $(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ldd
	@install -Dv -m 0755 $(BUILD_DIR)/uClibc-ng-1.0.26/utils/ldconfig.host $(TOOLS_DIR)/bin/ldconfig
	@ln -sf ldconfig $(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ldconfig

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "uClibc-ng 1.0.26"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@make defconfig -C $(BUILD_DIR)/uClibc-ng-1.0.26
	@sed -i -e "/\\<CROSS_COMPILER_PREFIX\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'CROSS_COMPILER_PREFIX="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-"' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<TARGET_arm\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'TARGET_arm=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<TARGET_ARCH\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'TARGET_ARCH="arm"' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<KERNEL_HEADERS\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'KERNEL_HEADERS="$(SYSROOT_DIR)/usr/include"' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<RUNTIME_PREFIX\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'RUNTIME_PREFIX="/"' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<DEVEL_PREFIX\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'DEVEL_PREFIX="/usr"' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<SHARED_LIB_LOADER_PREFIX\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'SHARED_LIB_LOADER_PREFIX="/lib"' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<ARCH_HAS_MMU\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'ARCH_HAS_MMU=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<ARCH_USE_MMU\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'ARCH_USE_MMU=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e '/CONFIG_ARM_.ABI/d' $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<CONFIG_ARM_EABI\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'CONFIG_ARM_EABI=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<ARCH_LITTLE_ENDIAN\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'ARCH_LITTLE_ENDIAN=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<ARCH_WANTS_LITTLE_ENDIAN\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'ARCH_WANTS_LITTLE_ENDIAN=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<ARCH_BIG_ENDIAN\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo '# ARCH_BIG_ENDIAN is not set' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<ARCH_WANTS_BIG_ENDIAN\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo '# ARCH_WANTS_BIG_ENDIAN is not set' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<UCLIBC_HAS_IPV6\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'UCLIBC_HAS_IPV6=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<UCLIBC_HAS_FPU\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'UCLIBC_HAS_FPU=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<UCLIBC_HAS_FLOATS\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'UCLIBC_HAS_FLOATS=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<UCLIBC_HAS_SSP\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo '# UCLIBC_HAS_SSP is not set' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<UCLIBC_BUILD_SSP\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo '# UCLIBC_BUILD_SSP is not set' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<UCLIBC_HAS_THREADS\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'UCLIBC_HAS_THREADS=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<UCLIBC_HAS_LINUXTHREADS\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo '# UCLIBC_HAS_LINUXTHREADS is not set' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<UCLIBC_HAS_THREADS_NATIVE\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'UCLIBC_HAS_THREADS_NATIVE=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<PTHREADS_DEBUG_SUPPORT\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo '# PTHREADS_DEBUG_SUPPORT is not set' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<UCLIBC_HAS_LOCALE\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo '# UCLIBC_HAS_LOCALE is not set' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<UCLIBC_HAS_WCHAR\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'UCLIBC_HAS_WCHAR=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@sed -i -e "/\\<HAVE_SHARED\\>/d" $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo 'HAVE_SHARED=y' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@echo '# UCLIBC_BUILD_PIE is not set' >> $(BUILD_DIR)/uClibc-ng-1.0.26/.config
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/uClibc-ng-1.0.26 ARCH=$(CONFIG_MODE) CROSS_COMPILE=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)- UCLIBC_EXTRA_CFLAGS="" HOSTCC=gcc headers
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/uClibc-ng-1.0.26 ARCH=$(CONFIG_MODE) CROSS_COMPILE=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)- UCLIBC_EXTRA_CFLAGS="" HOSTCC=gcc
	@make -j1 -C $(BUILD_DIR)/uClibc-ng-1.0.26 ARCH=$(CONFIG_MODE) CROSS_COMPILE=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)- UCLIBC_EXTRA_CFLAGS="" HOSTCC=gcc PREFIX=$(ROOTFS_DIR) DEVEL_PREFIX=/usr/ RUNTIME_PREFIX=/ install_runtime
	@make -j1 -C $(BUILD_DIR)/uClibc-ng-1.0.26 CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc CPP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-cpp LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld ARCH=$(CONFIG_MODE) PREFIX=$(ROOTFS_DIR) utils install_utils
