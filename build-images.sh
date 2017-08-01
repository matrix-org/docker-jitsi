#!/bin/bash

set -e

REPOSITORY=${1:-stable}

for image in jicofo videobridge; do
    docker build \
        --no-cache \
        --network=host \
        --build-arg "REPOSITORY=${REPOSITORY}" \
        -t ${image}:`date +%Y%m%d`-${REPOSITORY} \
        ${image}/
done
