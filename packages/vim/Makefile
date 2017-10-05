include $(SUPPORT_DIR)/functions.mk

NAME := vim
TARGET_DEPENDENCIES := ncurses
SOURCE := $(SOURCES_DIR)/vim-8.0.069.tar.bz2
SOURCE_URL := ftp://ftp.vim.org/pub/vim/unix/vim-8.0.069.tar.bz2
MD5 := 457543a7754b0d3c1c0aa4d4c3bb4070

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "Vim 8.0.069"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> $(BUILD_DIR)/vim80/src/feature.h
	@( cd $(BUILD_DIR)/vim80 && \
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
	vim_cv_toupper_broken=no \
	vim_cv_terminfo=yes \
	vim_cv_tty_group=world \
	vim_cv_tty_mode=0620 \
	vim_cv_getcwd_broken=no \
	vim_cv_stat_ignores_slash=yes \
	vim_cv_memmove_handles_overlap=yes \
	ac_cv_sizeof_int=4 \
	ac_cv_small_wchar_t=no \
	CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc \
	CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++ \
	AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar \
	AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as \
	LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld \
	RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib \
	READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf \
	STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--enable-multibyte \
	--enable-gui=no \
	--disable-gtktest \
	--disable-xim \
	--with-features=normal \
	--disable-gpm \
	--without-x \
	--disable-netbeans \
	--with-tlib=ncurses )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/vim80
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/vim80
	@ln -svf vim $(ROOTFS_DIR)/usr/bin/vi
	@ln -svf ../vim/vim80/doc $(ROOTFS_DIR)/usr/share/doc/vim-8.0.069
	@cp -v $(PACKAGES_DIR)/vim/vimrc $(ROOTFS_DIR)/etc/vimrc
	@rm -rf $(BUILD_DIR)/vim80
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
