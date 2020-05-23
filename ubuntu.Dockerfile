FROM ubuntu:latest

ARG PREFIX="/usr"
ARG SRC_DIR="${PREFIX}/src/libdistanceproto/"

WORKDIR ${SRC_DIR}
COPY LICENSE VERSION meson.build README.md ./
COPY src ./src/

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        libprotobuf-c-dev \
        libprotobuf-c1 \
        libprotobuf-dev \
        libprotobuf17 \
        ninja-build \
        pkg-config \
        protobuf-c-compiler \
        protobuf-compiler \
        python3-pip \
        python3-setuptools \
    && pip3 install meson \
    && mkdir build && cd build \
    && meson --prefix ${PREFIX} .. \
    && ninja && ninja install \
    && pip3 uninstall -y meson \
    && cd .. && rm -rf build \
    && apt-get purge -y --autoremove \
        build-essential \
        libprotobuf-c-dev \
        libprotobuf-dev \
        ninja-build \
        pkg-config \
        protobuf-c-compiler \
        protobuf-compiler \
        python3-pip \
        python3-setuptools \
    && rm -rf /var/lib/apt/lists/*
