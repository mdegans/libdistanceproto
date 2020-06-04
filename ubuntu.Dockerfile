FROM ubuntu:latest

ARG PREFIX="/usr/local"
ARG SRC_DIR="${PREFIX}/src/libdistanceproto/"
ARG VERSION="UNSET (use docker_build_ubuntu.sh to build)"
# dammit, why isn't this the default in docker
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR ${SRC_DIR}
COPY LICENSE VERSION README.md CMakeLists.txt ./
COPY src ./src/

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        libprotobuf-dev \
        ninja-build \
        protobuf-compiler \
    && mkdir build && cd build \
    && cmake -GNinja -DCMAKE_INSTALL_PREFIX:PATH=${PREFIX} .. \
    && ninja && ninja install \
    && ldconfig \
    && cd .. && rm -rf build \
    && apt-get purge -y --autoremove \
        build-essential \
        cmake \
        ninja-build \
        protobuf-compiler \
    && rm -rf /var/lib/apt/lists/*
