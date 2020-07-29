# libdistanceproto

Is a protobuf library for use with various social distancing projects. It may
be used commercially, however the library is LGPL so such modifications to the
library itself must be published under the same license.

You can use protoc or protoc-c as usual or cmake to build and link libraries.

## requirements

Protobuf libraries and protobuf compilers. Everything shoud be platform agnistic
so the library should build on windows, mac, etc.

Protobuf related dependencies:
```
sudo apt install libprotobuf-dev libprotobuf-c-dev protobuf-compiler protobuf-c-compiler
```

A build system such as cmake:
```
sudo apt install cmake ninja-build
```
(or meson)
```
sudo apt install meson ninja-build
```
(or if the meson version is not new enough)
```
sudo apt install ninja-build
pip3 install --upgrade meson
```

ninja-build is optional for cmake. You can use make instead as usual.

## building

Cmake (make can be used instaed of ninja as usual)

```bash
mkdir build
cd build
cmake -GNinja ..
ninja
(sudo) ninja install
```
Meson

```bash
mkdir builddir
cd builddir
meson ..
ninja
(sudo) ninja install
```
