#!/bin/sh

set -e

echo "$INPUT_SERVICE_ACCOUNT_KEY" | base64 --decode > "$HOME"/gcloud.json

if [ -z "$INPUT_CONTEXT" ]; then
    INPUT_CONTEXT="."
fi

if [ "$INPUT_TARGET" ]; then
    TARGET="--target ${INPUT_TARGET}"
fi

if [ "$INPUT_BUILD_ARGS" ]; then
    BUILD_ARGS_SPLIT=$(echo "$INPUT_BUILD_ARGS" | tr ',' '\n')
    BUILD_ARGS="--build-arg $(echo $BUILD_ARGS_SPLIT | xargs | sed 's/ / --build-arg /g')"
fi

docker build -f "$INPUT_DOCKERFILE" -t "$INPUT_IMAGE" $BUILD_ARGS "$INPUT_CONTEXT" $TARGET

gcloud auth activate-service-account --key-file="$HOME"/gcloud.json --project "$INPUT_PROJECT_ID"

gcloud auth configure-docker

docker push $INPUT_IMAGE
