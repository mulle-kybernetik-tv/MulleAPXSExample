#import <MulleObjC/MulleObjC.h>

#include "httpd.h"
#include "http_config.h"
#include "http_protocol.h"
#include "ap_config.h"


@interface HelloWorld : NSObject

- (uint32_t) gimme;

@end


@implementation HelloWorld

- (uint32_t) gimme
{
    extern uint32_t   mulle_objc_uniqueid_from_string( char *);
    uint32_t   hash;

    hash = mulle_objc_uniqueid_from_string( "foo");
    return( hash);
}
@end


/* The sample content handler */
int objc_example_handler(request_rec *r)
{
    if (strcmp(r->handler, "objc_example2_module")) {
        return DECLINED;
    }
    r->content_type = "text/html";      

    extern uint32_t   mulle_objc_uniqueid_from_string( char *);
    uint32_t   hash;

    hash = mulle_objc_uniqueid_from_string( "foo");

    if (!r->header_only)
    {
       id    obj;

       obj = [[HelloWorld new] autorelease];
       ap_rprintf(r, "<pre>"
                     "Universe     : 0x%lx\n", (unsigned long) (uintptr_t) _mulle_objc_object_get_universe( obj));
       ap_rprintf(r, "threadkey    : 0x%lx\n", (unsigned long) (uintptr_t) _mulle_objc_universe_get_threadkey( _mulle_objc_object_get_universe( obj)));
       ap_rprintf(r, "NSThread     : 0x%lx\n", (unsigned long) (uintptr_t) [NSThread currentThread]);
       ap_rprintf(r, "mulle-thread : 0x%lx\n", mulle_thread_self());
       ap_rprintf(r, "obj          : 0x%lx\n",  (unsigned long) (uintptr_t)  obj);
       ap_rprintf(r, "Hashed \"foo\" : %lx</pre>", (unsigned long) [obj gimme]); 
    }
    return OK;
}

