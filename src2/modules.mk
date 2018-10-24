mod_objc_example2.la: mod_objc_example2.slo
	$(SH_LINK) -rpath $(libexecdir) -module -avoid-version  mod_objc_example2.lo
DISTCLEAN_TARGETS = modules.mk
shared =  mod_objc_example2.la
