#!/bin/sh

set -e

echo "$INPUT_SERVICE_ACCOUNT_KEY" | base64 --decode > "$HOME"/gcloud.json

if [ -z "$INPUT_CONTEXT" ]; then
    INPUT_CONTEXT="."
fi

if [ "$INPUT_TARGET" ]; then
    TARGET="--target ${INPUT_TARGET}"
fi

echo docker build -f "$INPUT_DOCKERFILE" -t "$INPUT_IMAGE"  "$INPUT_CONTEXT" $TARGET

docker build -f "$INPUT_DOCKERFILE" -t "$INPUT_IMAGE"  "$INPUT_CONTEXT" $TARGET

gcloud auth activate-service-account --key-file="$HOME"/gcloud.json --project "$INPUT_PROJECT_ID"

gcloud auth configure-docker

docker push $INPUT_IMAGE
