#!/bin/bash

make clean
make \
CC=$DEVKITPRO/devkitPPC/bin/powerpc-eabi-gcc \
CXX=$DEVKITPRO/devkitPPC/bin/powerpc-eabi-g++ \
CFLAGS="-I./include -O2 -ffunction-sections -fdata-sections -DESPRESSO -mcpu=750 -meabi -mhard-float -D__WIIU__ -D__WUT__ -DBIGENDIAN -DFZ_ENABLE_BARCODE=0 -D_GNU_SOURCE -DCMS_NO_PTHREADS" \
CXXFLAGS="-I./include -O2 -ffunction-sections -fdata-sections -DESPRESSO -mcpu=750 -meabi -mhard-float -D__WIIU__ -D__WUT__ -DBIGENDIAN -DFZ_ENABLE_BARCODE=0 -D_GNU_SOURCE -DCMS_NO_PTHREADS" \
HAVE_X11=no \
HAVE_GL=no \
HAVE_GLUT=no \
HAVE_CURL=no \
HAVE_JS=no \
HAVE_SVG=no \
HAVE_HTML=no \
HAVE_LCMS2=no \
NO_TOOLS=yes \
HAVE_TEXT_OUTPUT=no \
NO_OCRLIB=yes \
build/release/libmupdf.a \
build/release/libmupdf-third.a

