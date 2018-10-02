mod_objc_example.la: mod_objc_example.slo
	$(SH_LINK) -rpath $(libexecdir) -module -avoid-version  mod_objc_example.lo
DISTCLEAN_TARGETS = modules.mk
shared =  mod_objc_example.la
