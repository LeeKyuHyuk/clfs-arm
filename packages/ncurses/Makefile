include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/ncurses-6.0.tar.gz
SOURCE_URL := http://ftpmirror.gnu.org/gnu/ncurses/ncurses-6.0.tar.gz
MD5 := ee13d052e1ead260d7c28071f46eefb1

toolchain:
	@$(STEP) "ncurses 6.0"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -i s/mawk// $(BUILD_DIR)/ncurses-6.0/configure
	@( cd $(BUILD_DIR)/ncurses-6.0 && \
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
	--without-debug \
	--without-ada \
	--enable-widec \
	--enable-overwrite )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/ncurses-6.0/include
	@make -j$(CONFIG_PARALLEL_JOBS) tic -C $(BUILD_DIR)/ncurses-6.0/progs
	@install -v -m755 $(BUILD_DIR)/ncurses-6.0/progs/tic $(TOOLS_DIR)/bin
	@rm -rf $(BUILD_DIR)/ncurses-6.0

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "ncurses 6.0"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/ncurses-6.0 && \
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
	CPPFLAGS="-P" \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--mandir=/usr/share/man \
	--with-shared \
	--without-debug \
	--without-normal \
	--enable-pc-files \
	--enable-widec )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/ncurses-6.0
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) PKG_CONFIG_LIBDIR=/usr/lib/pkgconfig install -C $(BUILD_DIR)/ncurses-6.0
	@$(call dependency_libs_patch)
	@for lib in ncurses form panel menu ; do \
		rm -vf                     $(SYSROOT_DIR)/usr/lib/lib$${lib}.so ; \
		echo "INPUT(-l$${lib}w)" > $(SYSROOT_DIR)/usr/lib/lib$${lib}.so ; \
		ln -sfv $${lib}w.pc        $(SYSROOT_DIR)/usr/lib/pkgconfig/$${lib}.pc ; \
	done
	@rm -vf                     $(SYSROOT_DIR)/usr/lib/libcursesw.so
	@echo "INPUT(-lncursesw)" > $(SYSROOT_DIR)/usr/lib/libcursesw.so
	@ln -sfv libncurses.so      $(SYSROOT_DIR)/usr/lib/libcurses.so
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) PKG_CONFIG_LIBDIR=/usr/lib/pkgconfig install -C $(BUILD_DIR)/ncurses-6.0
	@for lib in ncurses form panel menu ; do \
		rm -vf                     $(ROOTFS_DIR)/usr/lib/lib$${lib}.so ; \
		echo "INPUT(-l$${lib}w)" > $(ROOTFS_DIR)/usr/lib/lib$${lib}.so ; \
		ln -sfv $${lib}w.pc        $(ROOTFS_DIR)/usr/lib/pkgconfig/$${lib}.pc ; \
	done
	@rm -vf                     $(ROOTFS_DIR)/usr/lib/libcursesw.so
	@echo "INPUT(-lncursesw)" > $(ROOTFS_DIR)/usr/lib/libcursesw.so
	@ln -sfv libncurses.so      $(ROOTFS_DIR)/usr/lib/libcurses.so
	@rm -rf $(BUILD_DIR)/ncurses-6.0
