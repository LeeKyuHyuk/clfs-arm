include $(SUPPORT_DIR)/functions.mk

SOURCE := $(SOURCES_DIR)/tzdata2017b.tar.gz
SOURCE_URL := http://www.iana.org/time-zones/repository/releases/tzdata2017b.tar.gz
MD5 := 50dc0dc50c68644c1f70804f2e7a1625

ZONEINFO := $(ROOTFS_DIR)/usr/share/zoneinfo

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "tzdata2017b"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@mkdir -p $(BUILD_DIR)/tzdata2017b
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)/tzdata2017b
	@mkdir -pv $(ZONEINFO)/posix
	@mkdir -pv $(ZONEINFO)/right
	@for tz in $(BUILD_DIR)/tzdata2017b/etcetera $(BUILD_DIR)/tzdata2017b/southamerica $(BUILD_DIR)/tzdata2017b/northamerica $(BUILD_DIR)/tzdata2017b/europe $(BUILD_DIR)/tzdata2017b/africa $(BUILD_DIR)/tzdata2017b/antarctica $(BUILD_DIR)/tzdata2017b/asia $(BUILD_DIR)/tzdata2017b/australasia $(BUILD_DIR)/tzdata2017b/backward $(BUILD_DIR)/tzdata2017b/pacificnew $(BUILD_DIR)/tzdata2017b/systemv ; do \
		zic -L /dev/null -d $(ZONEINFO) -y "sh yearistype.sh" $${tz} ; \
		zic -L /dev/null -d $(ZONEINFO)/posix -y "sh yearistype.sh" $${tz} ; \
		zic -L $(BUILD_DIR)/tzdata2017b/leapseconds -d $(ZONEINFO)/right -y "sh yearistype.sh" $${tz} ; \
	done
	@cp -v $(BUILD_DIR)/tzdata2017b/zone.tab $(ZONEINFO)
	@cp -v $(BUILD_DIR)/tzdata2017b/zone1970.tab $(ZONEINFO)
	@cp -v $(BUILD_DIR)/tzdata2017b/iso3166.tab $(ZONEINFO)
	@zic -d $(ZONEINFO) -p America/New_York
	@if ! [ -f $(ROOTFS_DIR)/usr/share/zoneinfo/$(CONFIG_LOCAL_TIMEZONE) ] ; then \
	    echo "Seems like your timezone won't work out. Defaulting to Seoul. Either fix it yourself later or consider moving there." ; \
	    cp -v $(ROOTFS_DIR)/usr/share/zoneinfo/Asia/Seoul $(ROOTFS_DIR)/etc/localtime ; \
	else \
	    cp -v $(ROOTFS_DIR)/usr/share/zoneinfo/$(CONFIG_LOCAL_TIMEZONE) $(ROOTFS_DIR)/etc/localtime ; \
	fi;
	@rm -rf $(BUILD_DIR)/tzdata2017b
