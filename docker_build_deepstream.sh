#!/bin/bash

# This script build a DeepStream base version of distanceproto.

set -ex

# change this if you fork the repo and want to push you own image
readonly AUTHOR="mdegans"
readonly PROJ_NAME="libdistanceproto"
readonly DOCKERFILE_BASENAME="deepstream.Dockerfile"
readonly DEEPSTREAM_TAG="5.0-dp-20.04-devel"

# https://stackoverflow.com/questions/59895/how-to-get-the-source-directory-of-a-bash-script-from-within-the-script-itself
readonly THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
TAG_SUFFIX=$(git rev-parse --abbrev-ref HEAD)
if [[ $TAG_SUFFIX == "master" ]]; then
    TAG_SUFFIX="deepstream"
else
    TAG_SUFFIX="deepstream-$TAG_SUFFIX"
fi
readonly DOCKERFILE="$THIS_DIR/$DOCKERFILE_BASENAME"
readonly VERSION=$(head -n 1 $THIS_DIR/VERSION)
readonly TAG_BASE="$AUTHOR/$PROJ_NAME"
readonly TAG_FULL="$TAG_BASE:$VERSION-ds"

echo "Building $TAG_FULL from $DOCKERFILE"

docker build --rm -f $DOCKERFILE \
    --build-arg DEEPSTREAM_TAG="${DEEPSTREAM_TAG}" \
    --build-arg VERSION="${VERSION}" \
    -t $TAG_FULL \
    $THIS_DIR $@
docker tag "$TAG_FULL" "$TAG_BASE:$TAG_SUFFIX"
