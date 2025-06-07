# Building for devkitpro / devkitppc

# Status - WIP

libmupdf.a and lubmupdf-third.a compile for devkitpro wiiu environment

Still encountering linking issues.  (see project hito15/SDLReader)

## Compiling

In a devkitpro wiiu environment

```
# cd /project
# ./make_wiiu.sh
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

