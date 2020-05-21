# libdistanceproto

Is a protobuf library for use with various social distancing projects. It may
be used commercially, however the library is LGPL so such modifications to the
library itself must be published under the same license.

You can use protoc or protoc-c as usual or meson to build and link libraries.

## requirements

Protobuf libraries and protobuf compilers. Everything shoud be platform agnistic
so the library should build on windows, mac, etc.

Ubuntu/Debian dependency install:
```
sudo apt install libprotobuf-dev libprotobuf-c-dev protobuf-compiler protobuf-c-compiler
```

## building

More or less the same as with cmake and make only "meson" and "ninja" instead.

```bash
(sudo) apt install meson, ninja-build
mkdir build
cd build
meson ..
ninja
```

Libraries and generated headers can be found under build.

For now install doesn't work correctly. See known issues.

## known issues:

* header is installed to the wrong path (generator needs to be used instead of 
  custom_target) (or another build system that handles protobuf better)
