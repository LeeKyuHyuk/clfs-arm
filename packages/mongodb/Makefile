include $(SUPPORT_DIR)/functions.mk

NAME := mongodb
TARGET_DEPENDENCIES := openssl
SOURCE := $(SOURCES_DIR)/mongodb-src-r3.3.4.tar.gz
SOURCE_URL := https://fastdl.mongodb.org/src/mongodb-src-r3.3.4.tar.gz
MD5 := 9ae038589e8e65d58b5927ca094a84b1

system:
	@export CC=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc
	@export CXX=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++
	@export AR=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ar
	@export AS=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-as
	@export LD=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ld
	@export RANLIB=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-ranlib
	@export READELF=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-readelf
	@export STRIP=$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-strip
	@$(STEP) "mongodb 3.3.4"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call system_dependencies, $(TARGET_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@ln -svf $(BUILD_DIR)/mongodb-src-r3.3.4/src/mongo $(BUILD_DIR)/mongodb-src-r3.3.4/mongo
	@( cd $(BUILD_DIR)/mongodb-src-r3.3.4 && $(TOOLS_DIR)/bin/python2 $(TOOLS_DIR)/bin/scons CC="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc" CXX="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++" -j$(CONFIG_PARALLEL_JOBS) --disable-warnings-as-errors MONGO_VERSION=3.3.4- --wiredtiger=off --js-engine=none --allocator=system --ssl=SSL mongod mongo mongos )
	@( cd $(BUILD_DIR)/mongodb-src-r3.3.4 && $(TOOLS_DIR)/bin/python2 $(TOOLS_DIR)/bin/scons CC="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-gcc" CXX="$(TOOLS_DIR)/bin/$(CONFIG_TARGET)-g++" -j$(CONFIG_PARALLEL_JOBS) --disable-warnings-as-errors MONGO_VERSION=3.3.4- --wiredtiger=off --js-engine=none --allocator=system --ssl=SSL --prefix=$(ROOTFS_DIR)/usr install )
	@mkdir -p $(ROOTFS_DIR)/usr/local/mongodb/db
	@cp -v $(PACKAGES_DIR)/mongodb/mongos.conf $(ROOTFS_DIR)/usr/local/mongodb/mongos.conf
	@rm -rf $(BUILD_DIR)/mongodb-src-r3.3.4
	@echo $(NAME) >> $(SYSTEM_DEPENDENCIES)
