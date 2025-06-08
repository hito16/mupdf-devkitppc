# Building for devkitpro / devkitppc

# Status - WIP

libmupdf.a and lubmupdf-third.a compile for devkitpro wiiu environment

Still encountering linking issues.  (see project hito15/SDLReader)

## forking 
I did not forking the submodules.  If you also fork this repo, do the following

* fork the repo
  - eg your-user-id/mupdf-devkitppc
* In your fork, in the github UI
  - edit .gitmodules
  - update the third-party urls with https://github.com/ArtifexSoftware
  - save, commit, push to your fork
* remove your local fork directory
* do a recursive checkout
  - gh repo clone your-user-id/mupdf-devkitppc -- --recurse
  
## Compiling

In a devkitpro wiiu environment

```
# cd /project
# ./make_wiiu.sh
```
Files will be in 
```
build/release/libmupdf-third.a
build/release/libmupdf.a
```
## Linking

to statically link with your project on a devkitpro wiiu environment, 
you will need to address undefined references. 
At the moment, I am replicating the mupdf harfbuzz wrappers with my own.  (see SDLReader)


## changes
Buiding for the WiiU required the following changes

* modifying quad to stext_quad (see DEBUG_wiiu_quad.md)
* building without HARFBUZZ and FREETYPE  (see make_wiiu.sh)

Linking required:

* wrappers to address undefined references.

## Open concerns

### Fonts
mupdf copies compiled versions of fonts into the library
```
    OBJCOPY build/release/resources/fonts/sil/CharisSIL-BoldItalic.cff.o
    OBJCOPY build/release/resources/fonts/sil/CharisSIL-Italic.cff.o
    OBJCOPY build/release/resources/fonts/sil/CharisSIL.cff.o
    AR build/release/libmupdf.a
    ...
```

OBJCOPY_CMD may be using linker options that may not be compatible with the crosscompiler.

```
Makefile:OBJCOPY_CMD = $(QUIET_OBJCOPY) $(MKTGTDIR) ; $(LD) -r -b binary -z noexecstack -o $@ $<
Makefile:  $(OUT)/%.cff.o : %.cff ; $(OBJCOPY_CMD)
Makefile:  $(OUT)/%.otf.o : %.otf ; $(OBJCOPY_CMD)
Makefile:  $(OUT)/%.ttf.o : %.ttf ; $(OBJCOPY_CMD)
Makefile:  $(OUT)/%.ttc.o : %.ttc ; $(OBJCOPY_CMD)
```
