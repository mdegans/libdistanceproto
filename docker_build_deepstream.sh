#!/bin/bash

# This script build a DeepStream base version of distanceproto.

set -ex

# tag suffix based off git branch
TAG_SUFFIX=$(git rev-parse --abbrev-ref HEAD)
if [[ $TAG_SUFFIX == "master" ]]; then
    TAG_SUFFIX="deepstream"
else
    TAG_SUFFIX="deepstream-$TAG_SUFFIX"
fi

# get the version from VERSION file
readonly THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
VERSION=$(head -n 1 $THIS_DIR/VERSION)

# change this if you fork the repo and want to push you own image
readonly AUTHOR="mdegans"
readonly PROJ_NAME="libdistanceproto"
readonly DOCKERFILE_BASENAME="deepstream.Dockerfile"
if [[ "$(arch)" == "aarch64" ]]; then
    # Please, Nvidia, be consistent.
    # this whole file shouldn't be necessary.
    readonly TAG_SUFFIX="${TAG_SUFFIX}-tegra"
    readonly DEEPSTREAM_TAG="-l4t:5.0-dp-20.04-samples"
    readonly VERSION="${VERSION}-ds-tegra"
else
    readonly TAG_SUFFIX="${TAG_SUFFIX}-x86"
    readonly DEEPSTREAM_TAG=":5.0-dp-20.04-devel"
    readonly VERSION="${VERSION}-ds-x86"
fi

# https://stackoverflow.com/questions/59895/how-to-get-the-source-directory-of-a-bash-script-from-within-the-script-itself
readonly DOCKERFILE="$THIS_DIR/$DOCKERFILE_BASENAME"
readonly TAG_BASE="$AUTHOR/$PROJ_NAME"
readonly TAG_FULL="$TAG_BASE:$VERSION"

echo "Building $TAG_FULL from $DOCKERFILE"

docker build --rm -f $DOCKERFILE \
    --build-arg DEEPSTREAM_TAG="${DEEPSTREAM_TAG}" \
    --build-arg VERSION="${VERSION}" \
    -t $TAG_FULL \
    $THIS_DIR $@
docker tag "$TAG_FULL" "$TAG_BASE:$TAG_SUFFIX"
