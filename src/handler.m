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
    if (strcmp(r->handler, "objc_example")) {
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
       ap_rprintf(r, "Hashed foo to: %x\n", [obj gimme]);
    }
    return OK;
}

