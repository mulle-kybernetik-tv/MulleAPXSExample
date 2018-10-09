# MulleAPXSExample

Works on Ubuntu Linux with apache2.

## Feature: Thread Local Universe

This example uses the thread local universe feature of the mulle-objc-runtime. Therefore all Objective-C code must be compiled with the **-fobjc-tlu** flag.

This is done in the **mulle-sde** environment by specifying the `MULLE_SDE_MAKE_FLAGS` as `-DOTHER_CFLAGS=-fobjc-tlu`.

> See: `mulle-sde environment list`


## Memo: Apache/Libtool/ObjC

Libtool can not properly deal with the **--whole-archive** flag as researched
by reading [this](https://lists.gnu.org/archive/html/automake/2015-03/msg00000.html) 
and [this](https://lists.gnu.org/archive/html/libtool/2006-08/msg00007.html) maithread.

This makes it not feasible to link ObjC code statically into a Libtooling
environment such as an apache module. But linking a shared library to a C apache module is not a problem.

Build MulleObjC with STANDALONE. 

```
LD_RUN_PATH=$PWD/dependency/lib mulle-sde -v craft buildorder --release -- -DSTANDALONE=ON
sudo cp -a ../dependency/lib/libMulleObjC-standalone.so /usr/lib
```

Since we are going to install into `/usr/lib`
the `LD_RUN_PATH` is pointless.

Now build and install the module:

```
cd src
make
sudo make install
sudo LD_LIBRARY_PATH=$PWD/../dependency/lib:$LD_LIBRARY_PATH apache2ctl restart
```

Again the `LD_LIBRARY_PATH` is pointless, because the apache daemon doesn't
seem to pick it up. 





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

Read the [mulle_objc_example.c](src/mod_objc_example.c) for more information.


## Install

`apache2` contains configuration files that need to be added after
`sudo make install`
