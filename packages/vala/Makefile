include $(SUPPORT_DIR)/functions.mk

NAME := vala
HOST_DEPENDENCIES := glib
VALA_VERSION_MAJOR = 0.34
SOURCE := $(SOURCES_DIR)/vala-0.34.7.tar.xz
SOURCE_URL := http://ftp.gnome.org/pub/gnome/sources/vala/0.34/vala-0.34.7.tar.xz
MD5 := 3171bea9ac35020c14a67bbd8dc8b703

toolchain:
	@$(STEP) "vala 0.34.7"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@patch -Np1 -i $(PACKAGES_DIR)/vala/dont-add-dirty-to-valac-version.patch -d $(BUILD_DIR)/vala-0.34.7
	@( cd $(BUILD_DIR)/vala-0.34.7 && \
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
	--sysconfdir=$(TOOLS_DIR)/etc \
	--localstatedir=$(TOOLS_DIR)/var \
	--enable-shared \
	--disable-static )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/vala-0.34.7
	@make -j$(CONFIG_PARALLEL_JOBS) install -C $(BUILD_DIR)/vala-0.34.7
	@install -D -m 0755 $(PACKAGES_DIR)/vala/vala-wrapper $(TOOLS_DIR)/bin/vala
	@install -D -m 0755 $(PACKAGES_DIR)/vala/vala-wrapper $(TOOLS_DIR)/bin/valac
	@sed -i 's,@VALA_VERSION@,$(VALA_VERSION_MAJOR),' $(TOOLS_DIR)/bin/vala $(TOOLS_DIR)/bin/valac
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
	@rm -rf $(BUILD_DIR)/vala-0.34.7
