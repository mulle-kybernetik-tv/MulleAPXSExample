# MulleAPXSExample

Works on Ubuntu Linux with apache2. This page is
a collection of random thoughts. Read it all, if
you want to reproduce this.



## Research Findings

The apache daemon loads shared libraries with `RTLD_GLOBAL`. That means, that
the global universe variable is shared between modules. Therefore only one
global variable (not hashtable) universe exists and the modules share the
`libMulleObjC-standalone.so` loaded by the first extension.

Care must be taken, that classes have differing names.

> #### How to reproduce
>
> Build as explained in `Memo: Apache/Libtool/ObjC`
> then also build the second example in src2 likewise.
> Also install the `objc_example2.*` files in `./apache2` into the
> `mods-enabled` folder of `/etc/apache2` alongside the `objc_example.*` files.
>
> Then check [http://localhost/objc-example]() and [http://localhost/objc-example2]()
>


## Feature: Named Universes


This is done in by specifying `-DOTHER_CFLAGS=-fobjc-universename=myuniverse`.

#### Tweaks used to build the first universe

1. Set `MULLE_CRAFT_MULLE_OBJC_MAKE_FLAGS` to `-DSTANDALONE=ON`, so that MulleObjC gets build as a shared library, but not the constituent static libraries.
2. Specified a craftinfo for MulleObjC so that `OTHER_CFLAGS` is set to
`-fobjc-universename="vfl1848"`
3. Otherwise do as explained way below, and don't forget to copy the .so file.

#### Tweaks used to build the second universe

1. remove the old stuff with `mulle-sde clean all`
2. Specified a craftinfo for MulleObjC so that OTHER_CFLAGS is set to `-fobjc-universename="vfl1849"` (a different universename)
4. Change the **soname** of the standalone library to `libMulleObjC2-standalone.so`
3. rename built standalone library to `libMulleObjC2-standalone.so` and copy it
 to `/usr/lib`
5. Go into src2 and make and make install

> See: `mulle-sde environment list`


## Memo: Apache/Libtool/ObjC

Libtool can not properly deal with the **--whole-archive** flag as researched
by reading [this](https://lists.gnu.org/archive/html/automake/2015-03/msg00000.html)
and [this](https://lists.gnu.org/archive/html/libtool/2006-08/msg00007.html) mailthread.

This makes it not feasible to link ObjC code statically into a Libtooling
environment such as an apache module. But linking a shared library to a C apache module is not a problem.

Build MulleObjC with STANDALONE.

> Note: use tweak idea above

```
mulle-sde -v craft buildorder --release -- -DSTANDALONE=ON
sudo cp -a ../dependency/lib/libMulleObjC-standalone.so /usr/lib
```

Since we are going to install into `/usr/lib`
a `LD_RUN_PATH` seems pointless.

Now build and install the module:

```
cd src
make
sudo make install
sudo apache2ctl restart
```

Again a `LD_LIBRARY_PATH` would be pointless, because the apache daemon doesn't seem to pick it up. Or we would have to edit `/etc/apache2/envvars`.



## Install dependencies

This is a partial [mulle-sde](https://mulle-sde.github.io/) project.


```
mulle-sde MulleAPXSExample
```

Now you can let **mulle-sde** fetch the required dependencies and build the
project for you:

```
mulle-sde craft buildorder
```

## Build

Venture into the `src` directory and run `make`.

Read [mulle_objc_example.c](src/mod_objc_example.c) for more information.


## Install

`apache2` contains configuration files that need to be added after
`sudo make install`

## Debug

How to debug inside the apache.

```
$ sudo -s
# . /etc/apache2/envvars
# MULLE_SDE_TRACE_UNIVERSE=YES \
  MULLE_SDE_TRACE_ENABLED=YES \
  gdb /usr/sbin/apache2
gdb> set verbose on
gdb> run -X
```

