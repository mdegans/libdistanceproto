#!/bin/bash

# This script builds the generic, Ubuntu based version of distanceproto.

set -ex

# change this if you fork the repo and want to push you own image
readonly AUTHOR="mdegans"
readonly PROJ_NAME="libdistanceproto"
readonly DOCKERFILE_BASENAME="ubuntu.Dockerfile"

# https://stackoverflow.com/questions/59895/how-to-get-the-source-directory-of-a-bash-script-from-within-the-script-itself
readonly THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
TAG_SUFFIX=$(git rev-parse --abbrev-ref HEAD)
if [[ $TAG_SUFFIX == "master" ]]; then
    TAG_SUFFIX="latest"
fi
readonly DOCKERFILE="$THIS_DIR/$DOCKERFILE_BASENAME"
VERSION=$(head -n 1 $THIS_DIR/VERSION)

if [[ "$(arch)" == "aarch64" ]]; then
    readonly VERSION="${VERSION}-tegra"
    readonly TAG_SUFFIX="${TAG_SUFFIX}-tegra"
else
    readonly VERSION="${VERSION}-x86"
    readonly TAG_SUFFIX="${TAG_SUFFIX}-x86"
fi

readonly TAG_BASE="$AUTHOR/$PROJ_NAME"
readonly TAG_FULL="$TAG_BASE:$VERSION"

echo "Building $TAG_FULL from $DOCKERFILE"

docker build --rm -f $DOCKERFILE \
    --build-arg VERSION="${VERSION}" \
    -t $TAG_FULL \
    $THIS_DIR $@
docker tag "$TAG_FULL" "$TAG_BASE:$TAG_SUFFIX"
