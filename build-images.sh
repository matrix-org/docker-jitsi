#!/bin/bash
#
# Copyright 2017 Vector Creations Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

JICOFO_VERSION="*"
VIDEOBRIDGE_VERSION="*"
REPOSITORY="stable"

build_image() {
    local image="$1"
    local version="$2"
    local docker_args="$3"

    if [ -z "${version}" ] || [ "*x" = "${version}x" ]; then
        version=`date +%Y%m%d`-${REPOSITORY}
    fi

    echo ""
    echo "Building ${image}:${version} (with \"${docker_args}\")"

    docker build \
        --no-cache \
        --network=host \
        --build-arg "REPOSITORY=${REPOSITORY}" \
        $docker_args \
        -t ${image}:${version} \
        ${image}/
}


while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -h|--help)
        echo "Usage:"
        echo "build_images.sh [options]"
        echo ""
        echo "    -h|--help                     Display this help text"
        echo "    -j|--jicofo <version>         Set jicofo package version [default: * (i.e. latest)]"
        echo "    -v|--videobridge <version>    Set videobridge package version [default: * (i.e. latest)]"
        echo "    -r|--repository <string>      Set repository to stable or unstable [default: stable]"
        exit
        ;;
        -j|--jicofo)
        JICOFO_VERSION="${2:-*}"
        shift
        ;;
        -v|--videobridge)
        VIDEOBRIDGE_VERSION="${2:-*}"
        shift
        ;;
        -r|--repository)
        REPOSITORY="${2:-stable}"
        shift
        ;;
        *)
        echo "Unknown option $1"
        ;;
    esac
    shift
done

echo "Building images with:"
echo "JICOFO_VERSION: \"$JICOFO_VERSION\""
echo "VIDEOBRIDGE_VERSION: \"$VIDEOBRIDGE_VERSION\""
echo "REPOSITORY: \"$REPOSITORY\""

build_image jicofo "$JICOFO_VERSION" "--build-arg JICOFO_VERSION=${JICOFO_VERSION}"
build_image videobridge "$VIDEOBRIDGE_VERSION" "--build-arg VIDEOBRIDGE_VERSION=${VIDEOBRIDGE_VERSION}"
