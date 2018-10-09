/* 
**  mod_objc_example.c -- Apache sample objc_example module
**  [Autogenerated via ``apxs -n objc_example -g'']
**
**  To play with this sample module first compile it into a
**  DSO file and install it into Apache's modules directory 
**  by running:
**
**    $ apxs -c -i mod_objc_example.c
**
**  Then activate it in Apache's apache2.conf file for instance
**  for the URL /objc_example in as follows:
**
**    #   apache2.conf
**    LoadModule objc_example_module modules/mod_objc_example.so
**    <Location /objc_example>
**    SetHandler objc_example
**    </Location>
**
**  Then after restarting Apache via
**
**    $ apachectl restart
**
**  you immediately can request the URL /objc_example and watch for the
**  output of this module. This can be achieved for instance via:
**
**    $ lynx -mime_header http://localhost/objc_example 
**
**  The output should be similar to the following one:
**
**    HTTP/1.1 200 OK
**    Date: Tue, 31 Mar 1998 14:42:22 GMT
**    Server: Apache/1.3.4 (Unix)
**    Connection: close
**    Content-Type: text/html
**  
**    The sample page from mod_objc_example.c
*/ 

#include "httpd.h"
#include "http_config.h"
#include "http_protocol.h"
#include "ap_config.h"


extern int objc_example_handler(request_rec *r);

static void objc_example_register_hooks(apr_pool_t *p)
{
    ap_hook_handler(objc_example_handler, NULL, NULL, APR_HOOK_MIDDLE);
}

/* Dispatch list for API hooks */
module AP_MODULE_DECLARE_DATA objc_example_module = {
    STANDARD20_MODULE_STUFF, 
    NULL,                  /* create per-dir    config structures */
    NULL,                  /* merge  per-dir    config structures */
    NULL,                  /* create per-server config structures */
    NULL,                  /* merge  per-server config structures */
    NULL,                  /* table of config file commands       */
    objc_example_register_hooks  /* register hooks                      */
};

