include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/Python-2.7.13.tar.xz
SOURCE_URL := https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tar.xz
MD5 := 53b43534153bb2a0363f08bae8b9d990

toolchain:
	@$(STEP) "Python 2.7.13"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/Python-2.7.13 && \
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
	ac_cv_prog_HAS_HG=/bin/false \
	ac_cv_prog_SVNVERSION=/bin/false \
	./configure \
	--prefix=$(TOOLS_DIR) \
	--sysconfdir=$(TOOLS_DIR)/etc \
	--localstatedir=$(TOOLS_DIR)/var \
	--enable-shared \
	--enable-static \
	--with-system-expat \
	--with-system-ffi \
	--with-ensurepip=yes \
	--enable-unicode=ucs4 )
	@make -j1 -C $(BUILD_DIR)/Python-2.7.13
	@make -j1 install -C $(BUILD_DIR)/Python-2.7.13
	@ln -svf python2 $(TOOLS_DIR)/bin/python
	@ln -svf python2-config $(TOOLS_DIR)/bin/python-config
	@chmod -v 755 $(TOOLS_DIR)/lib/libpython2.7.so.1.0
	@rm -rf $(BUILD_DIR)/Python-2.7.13
