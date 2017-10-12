include $(SUPPORT_DIR)/functions.mk

NAME := seamonkey
TARGET_DEPENDENCIES := alsa-lib libgtk2 libgtk3 icu libevent nspr nss sqlite curl dbus-glib libstartup-notification wget cairo libffi pixman libpng libjpeg-turbo bzip2 zlib
SOURCE := $(SOURCES_DIR)/seamonkey-2.48.source.tar.xz
SOURCE_URL := https://archive.mozilla.org/pub/seamonkey/releases/2.48/source/seamonkey-2.48.source.tar.xz
MD5 := cf9ccf46be9359bd82e1931e083e942f

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "seamonkey 2.48"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@echo "CROSS_COMPILE=1" > $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "mk_add_options MOZ_MAKE_FLAGS=\"-j$(CONFIG_PARALLEL_JOBS)\"" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --target=$(CONFIG_TARGET)" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --enable-dbus" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --disable-necko-wifi" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --enable-startup-notification" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --disable-pulseaudio" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --disable-gconf" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --enable-system-sqlite" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --with-system-libevent" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --without-system-libvpx" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --with-system-nspr" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --with-system-nss" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --with-system-icu" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --prefix=/usr" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --enable-application=suite" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --disable-crashreporter" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --disable-updater" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --disable-tests" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --enable-optimize=\"-O2\"" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --enable-strip" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --enable-install-strip" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --enable-gio" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --enable-official-branding" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --enable-safe-browsing" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --enable-url-classifier" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --enable-system-cairo" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --enable-system-ffi" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --enable-system-pixman" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --with-pthreads" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --with-system-bz2" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --with-system-jpeg" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --with-system-png" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@echo "ac_add_options --with-system-zlib" >> $(BUILD_DIR)/seamonkey-2.48/mozconfig
	@CFLAGS="-O2 -fno-delete-null-pointer-checks -fno-lifetime-dse -fno-schedule-insns2" CXXFLAGS="-O2 -fno-delete-null-pointer-checks -fno-lifetime-dse -fno-schedule-insns2" make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/seamonkey-2.48 -f client.mk
	@CFLAGS="-O2 -fno-delete-null-pointer-checks -fno-lifetime-dse -fno-schedule-insns2" CXXFLAGS="-O2 -fno-delete-null-pointer-checks -fno-lifetime-dse -fno-schedule-insns2" make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/seamonkey-2.48 -f client.mk install INSTALL_SDK= DESTDIR=$(ROOTFS_DIR)
	@rm -rf $(BUILD_DIR)/seamonkey-2.48
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
