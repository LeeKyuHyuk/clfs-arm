include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/dbus-1.10.22.tar.gz
SOURCE_URL := https://dbus.freedesktop.org/releases/dbus/dbus-1.10.22.tar.gz
MD5 := baaa10b7cb49086ad91179a8decfadc5

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "dbus 1.10.22"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/dbus-1.10.22 && \
	PKG_CONFIG="$(TOOLS_DIR)/usr/bin/pkg-config" \
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
	ac_cv_have_abstract_sockets=yes \
	CONFIG_SITE=/dev/null \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--exec-prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--program-prefix="" \
	--disable-static \
	--enable-shared \
	--with-dbus-user=dbus \
	--disable-tests \
	--disable-asserts \
	--enable-abstract-sockets \
	--disable-selinux \
	--disable-xml-docs \
	--disable-doxygen-docs \
	--disable-dnotify \
	--with-xml=expat \
	--with-system-socket=/var/run/dbus/system_bus_socket \
	--with-system-pid-file=/var/run/messagebus.pid \
	--with-init-scripts=none \
	--disable-selinux \
	--disable-libaudit \
	--with-x \
	--disable-systemd )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/dbus-1.10.22
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(SYSROOT_DIR) install -C $(BUILD_DIR)/dbus-1.10.22
	@$(call dependency_libs_patch)
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/dbus-1.10.22
	@echo 'messagebus:x:18:' >> $(ROOTFS_DIR)/etc/group
	@echo 'messagebus:x:18:18:D-Bus Message Daemon User:/var/run/dbus:/bin/false' >> $(ROOTFS_DIR)/etc/passwd
	@cp -v $(PACKAGES_DIR)/dbus/session-local.conf $(ROOTFS_DIR)/etc/dbus-1/session-local.conf
	@mkdir -p $(ROOTFS_DIR)/var/lib
	@rm -rf $(ROOTFS_DIR)/var/lib/dbus
	@ln -sf /tmp/dbus $(ROOTFS_DIR)/var/lib/dbus
	@rm -rf $(ROOTFS_DIR)/usr/lib/dbus-1.0
	@rm -rf $(BUILD_DIR)/dbus-1.10.22
