ARG DEEPSTREAM_TAG="5.0-dp-20.04-devel"
FROM nvcr.io/nvidia/deepstream:${DEEPSTREAM_TAG}

ARG PREFIX="/usr/local"
ARG SRC_DIR="${PREFIX}/src/libdistanceproto/"
ARG VERSION="UNSET (use docker_build_ubuntu.sh to build)"
# dammit, why isn't this the default in docker
ARG DEBIAN_FRONTEND=noninteractive

# fix deepstream permissions and ldconfig
RUN chmod -R o-w /opt/nvidia/deepstream/deepstream-5.0/ \
    && echo "/opt/nvidia/deepstream/deepstream/lib" > /etc/ld.so.conf.d/deepstream.conf \
    && ldconfig

WORKDIR ${SRC_DIR}
COPY LICENSE VERSION README.md CMakeLists.txt ./
COPY src ./src/

RUN apt-get update && apt-get install -y --no-install-recommends \
        cmake \
        libprotobuf-dev \
        ninja-build \
        protobuf-compiler \
    && mkdir build && cd build \
    && cmake -GNinja -DCMAKE_INSTALL_PREFIX:PATH=${PREFIX} .. \
    && ninja && ninja install \
    && cd .. && rm -rf build \
    && apt-get purge -y --autoremove \
        cmake \
        ninja-build \
        protobuf-compiler \
    && rm -rf /var/lib/apt/lists/*
