#!/bin/bash

# This script build a DeepStream base version of distanceproto.

set -ex

# tag suffix based off git branch
TAG_SUFFIX=$(git rev-parse --abbrev-ref HEAD)
if [[ $TAG_SUFFIX == "master" ]]; then
    TAG_SUFFIX="ds"
else
    TAG_SUFFIX="ds-$TAG_SUFFIX"
fi

# get the version from VERSION file
readonly THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
VERSION=$(head -n 1 $THIS_DIR/VERSION)

# change this if you fork the repo and want to push you own image
readonly AUTHOR="mdegans"
readonly PROJ_NAME="libdistanceproto"

# change this if you want to override the architecture (cross build)
# this is untested and unsupported
readonly ARCH="$(arch)"

readonly TAG_SUFFIX="${TAG_SUFFIX}-$ARCH"
readonly VERSION="${VERSION}-ds-$ARCH"

readonly DOCKERFILE_BASENAME="deepstream.Dockerfile"
if [[ $ARCH == "aarch64" ]]; then
    # Please, Nvidia, be consistent.
    # this whole file shouldn't be necessary.
    readonly BASE_IMAGE="registry.hub.docker.com/mdegans/deepstream:aarch64-samples"
else
    readonly BASE_IMAGE="nvcr.io/nvidia/deepstream:5.0-dp-20.04-devel"
fi

# https://stackoverflow.com/questions/59895/how-to-get-the-source-directory-of-a-bash-script-from-within-the-script-itself
readonly DOCKERFILE="$THIS_DIR/$DOCKERFILE_BASENAME"
readonly TAG_BASE="$AUTHOR/$PROJ_NAME"
readonly TAG_FULL="$TAG_BASE:$VERSION"

echo "Building $TAG_FULL from $DOCKERFILE"

docker build --pull --rm -f $DOCKERFILE \
    --build-arg BASE_IMAGE="${BASE_IMAGE}" \
    --build-arg VERSION="${VERSION}" \
    -t $TAG_FULL \
    $THIS_DIR $@
docker tag "$TAG_FULL" "$TAG_BASE:$TAG_SUFFIX"
