##
##  Makefile -- Build procedure for sample objc_example Apache module
##  Autogenerated via ``apxs -n objc_example -g''.
##

builddir=.
top_srcdir=/usr/share/apache2
top_builddir=/usr/share/apache2
dependency_dir=../dependency

## inline from /usr/share/apache2/build/special.mk >

all: all-recursive

# include $(builddir)/modules.mk

## inline from /usr/share/apache2/build/special.mk <

## inline from modules.mk >

mod_objc_example2.la: mod_objc_example2.slo libobjc-library.a
	$(SH_LINK) -rpath $(libexecdir) -module -avoid-version  mod_objc_example2.lo
DISTCLEAN_TARGETS = modules.mk
shared =  mod_objc_example2.la

## inline from modules.mk <

## inline from /usr/share/apache2/build/special.mk >


TARGETS = $(static)
SHARED_TARGETS = $(shared)
INSTALL_TARGETS = install-modules-$(INSTALL_DSO)

include $(top_builddir)/build/rules.mk

install-modules-yes: $(SHARED_TARGETS)
	@$(MKINSTALLDIRS) $(DESTDIR)$(libexecdir)
	@list='$(shared)'; for i in $$list; do \
	  $(top_srcdir)/build/instdso.sh SH_LIBTOOL='$(SH_LIBTOOL)' $$i $(DESTDIR)$(libexecdir); \
	done

install-modules-no:

## inline from /usr/share/apache2/build/special.mk <


#   the used tools
APACHECTL=apachectl

#   additional defines, includes and libraries
#DEFS=-Dmy_define=my_value
INCLUDES=-I${dependency_dir}/include
OBJC_LIBRARIES=-lobjc-library -lMulleObjC2-standalone -lpthread -ldl
EXTRA_LDFLAGS=-L. -L${dependency_dir}/lib $(OBJC_LIBRARIES) $(C_LIBRARIES)



.SUFFIXES: .o .m

# -fobjc-universename="u1848" 
%.o:	%.m
	mulle-clang -c -fobjc-universename="vfl1849" -fPIC $(ALL_CFLAGS) $(ALL_CPPFLAGS) $(ALL_INCLUDES) $(INCLUDES) $< 

libobjc-library.a:	handler.o
	ar cru $@ $< 


#   the default target
all: local-shared-build

#   install the shared object file into Apache 
install: install-modules-yes

#   cleanup
clean:
	-rm -f mod_objc_example2.o mod_objc_example2.lo mod_objc_example2.slo mod_objc_example2.la 

#   simple test
test: reload
	lynx -mime_header http://localhost/objc_example2

#   install and activate shared object by reloading Apache to
#   force a reload of the shared object file
reload: install restart

#   the general Apache start/restart/stop
#   procedures
start:
	$(APACHECTL) start
restart:
	$(APACHECTL) restart
stop:
	$(APACHECTL) stop

