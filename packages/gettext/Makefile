include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/gettext-0.19.8.1.tar.xz
SOURCE_URL := http://ftp.gnu.org/gnu/gettext/gettext-0.19.8.1.tar.xz
MD5 := df3f5690eaa30fd228537b00cb7b7590

toolchain:
	@$(STEP) "gettext 0.19.8.1"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -i -e '/^SUBDIRS/s/ doc //;/^SUBDIRS/s/examples$$//' $(BUILD_DIR)/gettext-0.19.8.1/gettext-tools/Makefile.in
	@sed -i -e '/^SUBDIRS/s/ doc //;/^SUBDIRS/s/tests$$//' $(BUILD_DIR)/gettext-0.19.8.1/gettext-tools/Makefile.in
	@( cd $(BUILD_DIR)/gettext-0.19.8.1/gettext-tools && autoconf )
	@( cd $(BUILD_DIR)/gettext-0.19.8.1/gettext-tools && \
	PKG_CONFIG="$(TOOLS_DIR)/usr/bin/pkg-config" \
	PKG_CONFIG_SYSROOT_DIR="/" \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
	PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/usr/lib/pkgconfig:$(TOOLS_DIR)/usr/share/pkgconfig" \
	CPPFLAGS="-I$(TOOLS_DIR)/usr/include" \
	CFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
	CXXFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
	LDFLAGS="-L$(TOOLS_DIR)/usr/lib -Wl,-rpath,$(TOOLS_DIR)/usr/lib" \
	CONFIG_SITE=/dev/null \
	./configure \
	--prefix=$(TOOLS_DIR)/usr \
	--sysconfdir=$(TOOLS_DIR)/etc \
	--localstatedir=$(TOOLS_DIR)/var \
	--enable-shared \
	--disable-static \
	--disable-libasprintf \
	--disable-acl \
	--disable-openmp \
	--disable-rpath \
	--disable-java \
	--disable-native-java \
	--disable-csharp \
	--disable-relocatable \
	--without-emacs )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/gettext-0.19.8.1/gettext-tools
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/gettext-0.19.8.1/gettext-tools
	@sed -i -e '/read dummy/d' $(TOOLS_DIR)/usr/bin/gettextize
	@rm -rf $(BUILD_DIR)/gettext-0.19.8.1
