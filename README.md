# Building for devkitpro / devkitppc

## Changes

changing references from quad to stext_quad to avoid compiler errors.

```
// Modified (with conditional compilation):
#ifdef __WIIU__
ch->stext_quad.ll = fz_make_point(p->x + d.x, p->y + d.y);
#else
ch->quad.ll = fz_make_point(p->x + d.x, p->y + d.y);
#endif
```


## Problem
I'm cross compiling this using /opt/devkitpro/devkitPPC/powerpc-eabi.   I get the following errors.

```
./make_wiiu.sh 
/project/mupdf
Executing command: make CC=/opt/devkitpro/devkitPPC/bin/powerpc-eabi-gcc CXX=/opt/devkitpro/devkitPPC/bin/powerpc-eabi-g++ CFLAGS="-I./include -O2 -ffunction-sections -fdata-sections -DESPRESSO -mcpu=750 -meabi -mhard-float -D__WIIU__ -D__WUT__ -DBIGENDIAN" CXXFLAGS="-I./include -O2 -ffunction-sections -fdata-sections -DESPRESSO -mcpu=750 -meabi -mhard-float -D__WIIU__ -D__WUT__ -DBIGENDIAN" HAVE_X11=no HAVE_GL=no HAVE_GLUT=no HAVE_CURL=no HAVE_JS=no HAVE_SVG=no HAVE_HTML=no NO_TOOLS=yes HAVE_TEXT_OUTPUT=no NO_OCRLIB=yes build/release/source/fitz/output-csv.o 
#--debug=v
    CC build/release/source/fitz/output-csv.o
In file included from thirdparty/zlib/zconf.h:446,
                 from thirdparty/zlib/zlib.h:34,
                 from source/fitz/output-csv.c:25:
source/fitz/output-csv.c: In function 'whitespaceless_bbox':
source/fitz/output-csv.c:116:84: error: 'fz_stext_char' has no member named 'quad_t'; did you mean 'quad'?
  116 |                                         r = fz_union_rect(r, fz_rect_from_quad(ch->quad));
      |                                                                                    ^~~~
make: *** [Makefile:139: build/release/source/fitz/output-csv.o] Error 1  
```

Strange the compiler mentions quad as a type for member "quad_t".  Let's check for "quad_t" definitions in the mupdf repo.  Does "quad_t"  exist?

```
root@devkitppc:/project/mupdf# grep -r quad_t .
root@devkitppc:/project/mupdf# 
```

However, when we look at /opt/ we see a system include has this.
```
root@devkitppc:/project/mupdf# grep -r quad_t /opt
/opt/devkitpro/devkitPPC/powerpc-eabi/include/sys/types.h:#  define	quad		quad_t
/opt/devkitpro/devkitPPC/powerpc-eabi/include/machine/types.h:typedef	__uint64_t	u_quad_t;
/opt/devkitpro/devkitPPC/powerpc-eabi/include/machine/types.h:typedef	__int64_t	quad_t;
/opt/devkitpro/devkitPPC/powerpc-eabi/include/machine/types.h:typedef	quad_t *	qaddr_t;
/opt/devkitpro/devkitARM/arm-none-eabi/include/sys/types.h:#  define	quad		quad_t
/opt/devkitpro/devkitARM/arm-none-eabi/include/machine/types.h:typedef	__uint64_t	u_quad_t;
/opt/devkitpro/devkitARM/arm-none-eabi/include/machine/types.h:typedef	__int64_t	quad_t;
/opt/devkitpro/devkitARM/arm-none-eabi/include/machine/types.h:typedef	quad_t *	qaddr_t;
```

The compiler isn't a wrapper I can change.
```
file $DEVKITPRO/devkitPPC/bin/powerpc-eabi-gcc
/opt/devkitpro/devkitPPC/bin/powerpc-eabi-gcc: ELF 64-bit LSB executable, x86-64, version 1 (GNU/Linux), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=c8ad049f527dd544e30072509f7bd57749dfe488, for GNU/Linux 3.2.0, stripped
```

The affected files with quad
```
root@devkitppc:/project/mupdf# (grep -r '\->quad' source && grep -r '\.quad' source) | awk -F: '{ print $1 }' | sort -u
source/fitz/output-csv.c
source/fitz/output-docx.c
source/fitz/path.c
source/fitz/stext-boxer.c
source/fitz/stext-device.c
source/fitz/stext-output.c
source/fitz/stext-para.c
source/fitz/stext-search.c
source/fitz/stext-table.c
source/tools/murun.c
```

Number of occurances (at most)
```
root@devkitppc:/project/mupdf# grep -r '\->quad' source  | wc -l
74
root@devkitppc:/project/mupdf# grep -r '\.quad' source  | wc -l
8
``
