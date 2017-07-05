define check_source
	@if ! [ -f $(1) ] ; then \
		wget $(3) -c -P $(SOURCES_DIR) 2>&1 >/dev/null; true ; \
	else \
		if ! [ `md5sum $(1)  | cut -d ' ' -f 1` = $(2) ] ; then \
			wget $(3) -c -P $(SOURCES_DIR) 2>&1 >/dev/null; true ; \
		fi; \
	fi;
endef
