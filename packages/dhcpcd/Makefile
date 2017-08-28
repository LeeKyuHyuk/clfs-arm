include $(SUPPORT_DIR)/functions.mk

SOURCE := $(PACKAGES_DIR)/dhcpcd/dhcpcd-6.11.5.tar.xz
SOURCE_URL := http://roy.marples.name/downloads/dhcpcd/dhcpcd-6.11.5.tar.xz
MD5 := 2465624b62c1154f0e89dc69c42c849b

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "dhcpcd 6.11.5"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/dhcpcd-6.11.5 && \
	CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc \
	CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++ \
	AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar \
	AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as \
	LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld \
	RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib \
	READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf \
	STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip \
	CXX=false \
	./configure \
	--os=linux \
	--libexecdir=/lib/dhcpcd )
	@make -j$(CONFIG_PARALLEL_JOBS) all -C $(BUILD_DIR)/dhcpcd-6.11.5
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/dhcpcd-6.11.5
	@rm -rf $(BUILD_DIR)/dhcpcd-6.11.5
