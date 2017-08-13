include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/Python-2.7.13.tar.xz
SOURCE_URL := https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tar.xz
MD5 := 53b43534153bb2a0363f08bae8b9d990

toolchain:
	@$(STEP) "Python 2.7.13"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/python2/setup.py-do-not-add-invalid-header-locations.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Fix-get_python_inc-for-cross-compilation.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Change-the-install-location-of-_sysconfigdata.py.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Make-the-compilation-of-.pyc-and-.pyo-conditional.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Adjust-getaddrinfo-test-for-cross-compilation.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Add-minimal-infrastructure-to-be-able-to-disable-ext.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Adjust-library-header-paths-for-cross-compilation.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Don-t-look-in-usr-lib-termcap-for-libraries.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Fix-python-config-for-cross-builds.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Remove-the-python-symlink-install-rules.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Don-t-add-multiarch-paths.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Abort-on-failed-module-build.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/sqlite3-fix-build-when-threads-are-not-used-availabl.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Serial-ioctl-workaround.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Do-not-adjust-the-shebang-of-Python-scripts-for-cros.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Add-an-option-to-disable-installation-of-test-module.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Add-an-option-to-disable-pydoc.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Add-an-option-to-disable-lib2to3.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Add-option-to-disable-the-sqlite3-module.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Add-an-option-to-disable-the-tk-module.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Add-an-option-to-disable-the-curses-module.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Add-an-option-to-disable-expat.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Add-an-option-to-disable-CJK-codecs.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Add-an-option-to-disable-NIS.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Add-an-option-to-disable-unicodedata.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Add-an-option-to-disable-bsddb.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Add-an-option-to-disable-the-ssl-module.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Add-an-option-to-disable-the-bz2-module.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Add-an-option-to-disable-the-zlib-module.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Do-not-install-the-idle-editor.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Add-an-option-to-disable-the-ossaudiodev-module.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Add-option-to-disable-the-hashlib-module.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Add-an-option-to-disable-readline-module.patch -d $(BUILD_DIR)/Python-2.7.13
	@patch -Np1 -i $(PACKAGES_DIR)/python2/Override-system-locale-and-set-to-default-when-addin.patch -d $(BUILD_DIR)/Python-2.7.13
	@( cd $(BUILD_DIR)/Python-2.7.13 && \
	PKG_CONFIG="$(TOOLS_DIR)/usr/bin/pkg-config" \
	PKG_CONFIG_SYSROOT_DIR="/" \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
	PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/usr/lib/pkgconfig:$(TOOLS_DIR)/usr/share/pkgconfig" \
	CPPFLAGS="-I$(TOOLS_DIR)/usr/include" \
	CFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
	CXXFLAGS="-O2 -I$(TOOLS_DIR)/usr/include" \
	LDFLAGS="-L$(TOOLS_DIR)/usr/lib -Wl,-rpath,$(TOOLS_DIR)/usr/lib -Wl,--enable-new-dtags" \
	ac_cv_prog_HAS_HG=/bin/false \
	ac_cv_prog_SVNVERSION=/bin/false \
	CONFIG_SITE=/dev/null \
	./configure \
	--prefix=$(TOOLS_DIR)/usr \
	--sysconfdir=$(TOOLS_DIR)/etc \
	--localstatedir=$(TOOLS_DIR)/var \
	--enable-shared \
	--enable-static \
	--without-cxx-main \
	--disable-sqlite3 \
	--disable-tk \
	--with-expat=system \
	--disable-curses \
	--disable-codecs-cjk \
	--disable-nis \
	--enable-unicodedata \
	--disable-dbm \
	--disable-gdbm \
	--disable-bsddb \
	--disable-test-modules \
	--disable-bz2 \
	--disable-ssl \
	--disable-ossaudiodev \
	--disable-pyo-build )
	@make -j1 -C $(BUILD_DIR)/Python-2.7.13
	@make -j1 install -C $(BUILD_DIR)/Python-2.7.13
	@ln -svf python2 $(TOOLS_DIR)/usr/bin/python
	@ln -svf python2-config $(TOOLS_DIR)/usr/bin/python-config
	@rm -rf $(BUILD_DIR)/Python-2.7.13
