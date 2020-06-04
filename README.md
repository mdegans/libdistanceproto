# libdistanceproto

Is a protobuf library for use with various social distancing projects. It may
be used commercially, however the library is LGPL so such modifications to the
library itself must be published under the same license.

You can use protoc or protoc-c as usual or cmake to build and link libraries.

## requirements

Protobuf libraries and protobuf compilers. Everything shoud be platform agnistic
so the library should build on windows, mac, etc.

Ubuntu/Debian build dependency install:
```
sudo apt install libprotobuf-dev libprotobuf-c-dev protobuf-compiler protobuf-c-compiler cmake ninja-build
```

ninja-build is optional. You can use make instead as usual.

## building

More or less the same as with cmake and make only "meson" and "ninja" instead.

```bash
mkdir build
cd build
cmake -GNinja ..
ninja
(sudo) ninja install
```
