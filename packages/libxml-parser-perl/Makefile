include $(SUPPORT_DIR)/functions.mk

NAME := libxml-parser-perl
HOST_DEPENDENCIES := expat
SOURCE := $(SOURCES_DIR)/XML-Parser-2.44.tar.gz
SOURCE_URL := http://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.44.tar.gz
MD5 := af4813fe3952362451201ced6fbce379

toolchain:
	@$(STEP) "XML Parser 2.44"
	@$(call check_source, $(SOURCE), $(MD5), $(SOURCE_URL))
	@$(call toolchain_dependencies, $(HOST_DEPENDENCIES))
	@$(EXTRACT) $(SOURCE) $(BUILD_DIR)
	@( cd $(BUILD_DIR)/XML-Parser-2.44 && \
	PKG_CONFIG="$(TOOLS_DIR)/bin/pkg-config" \
	PKG_CONFIG_SYSROOT_DIR="/" \
	PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 \
	PKG_CONFIG_ALLOW_SYSTEM_LIBS=1 \
	PKG_CONFIG_LIBDIR="$(TOOLS_DIR)/lib/pkgconfig:$(TOOLS_DIR)/share/pkgconfig" \
	CPPFLAGS="-I$(TOOLS_DIR)/include" \
	CFLAGS="-O2 -I$(TOOLS_DIR)/include" \
	CXXFLAGS="-O2 -I$(TOOLS_DIR)/include" \
	LDFLAGS="-L$(TOOLS_DIR)/lib -Wl,-rpath,$(TOOLS_DIR)/lib" \
	`which perl` Makefile.PL \
	PREFIX=$(TOOLS_DIR) \
	EXPATLIBPATH=$(TOOLS_DIR)/lib \
	EXPATINCPATH=$(TOOLS_DIR)/include \
	INSTALLDIRS=site \
	INSTALLSITELIB=$(TOOLS_DIR)/lib/perl \
	INSTALLSITEARCH=$(TOOLS_DIR)/lib/perl )
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/XML-Parser-2.44
	@make -j$(CONFIG_PARALLEL_JOBS) -C $(BUILD_DIR)/XML-Parser-2.44 install
	@rm -rf $(BUILD_DIR)/XML-Parser-2.44
	@echo $(NAME) >> $(TOOLCHAIN_DEPENDENCIES)
