include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/iproute2-4.10.0.tar.xz
SOURCE_URL := https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-4.10.0.tar.xz
MD5 := b94a2b0edefaeac124dc8f5d006931b9

system:
	@export CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "iproute2 4.10.0"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@sed -i /ARPD/d $(BUILD_DIR)/iproute2-4.10.0/Makefile
	@sed -i 's/arpd.8//' $(BUILD_DIR)/iproute2-4.10.0/man/man8/Makefile
	@rm -v $(BUILD_DIR)/iproute2-4.10.0/doc/arpd.sgml
	@sed -i 's/m_ipt.o//' $(BUILD_DIR)/iproute2-4.10.0/tc/Makefile
	@( cd $(BUILD_DIR)/iproute2-4.10.0 && \
	CC=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-gcc \
	CXX=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-g++ \
	AR=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ar \
	AS=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-as \
	LD=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ld \
	RANLIB=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-ranlib \
	READELF=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-readelf \
	STRIP=$(TOOLS_DIR)/usr/bin/$(CONFIG_TARGET)-strip \
	./configure \
	--target=$(CONFIG_TARGET) \
	--host=$(CONFIG_TARGET) \
	--build=$(CONFIG_HOST) \
	--prefix=/usr \
	--docdir=/usr/share/doc/iproute2-4.10.0 )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/iproute2-4.10.0
	@make -j$(CONFIG_PARALLEL_JOBS) DESTDIR=$(ROOTFS_DIR) install -C $(BUILD_DIR)/iproute2-4.10.0
	@rm -rf $(BUILD_DIR)/iproute2-4.10.0
