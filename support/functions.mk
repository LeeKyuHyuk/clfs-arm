define check_source
	@if ! [ -f $(1) ] ; then \
		wget $(3) -c -P $(SOURCES_DIR) 2>&1 >/dev/null; true ; \
	else \
		if ! [ `md5sum $(1)  | cut -d ' ' -f 1` = $(2) ] ; then \
			wget $(3) -c -P $(SOURCES_DIR) 2>&1 >/dev/null; true ; \
		fi; \
	fi;
endef

define dependency_libs_patch
	@for lib in $(SYSROOT_DIR)/usr/lib/*.la ; do \
		while ! [ `grep " /usr/lib/\(.*\).la" $${lib}` -n ] ; do \
			sed -i "s@ /usr/lib/\(.*\).la@ $(SYSROOT_DIR)/usr/lib/\1.la@g" $${lib} ; \
		done ; \
		while ! [ `grep " /lib/\(.*\).la" $${lib}` -n ] ; do \
			sed -i "s@ /lib/\(.*\).la@ $(SYSROOT_DIR)/lib/\1.la@g" $${lib} ; \
		done ; \
	done; 2>&1 >/dev/null
endef

define toolchain_dependencies
	@for dependencie in $(1) ; do \
		if ! grep -q $${dependencie} $(TOOLCHAIN_DEPENDENCIES) ; then \
			$(ERROR) "[!! ERROR !!] Dependency package '$${dependencie}' is not in step 'toolchain'." ; \
			exit 1 ; \
		fi ; \
	done
endef

define system_dependencies
	@for dependencie in $(1) ; do \
		if ! grep -q $${dependencie} $(SYSTEM_DEPENDENCIES) ; then \
			$(ERROR) "[!! ERROR !!] Dependency package '$${dependencie}' is not in step 'system'." ; \
			exit 1 ; \
		fi ; \
	done
endef
