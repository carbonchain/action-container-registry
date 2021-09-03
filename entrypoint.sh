#!/bin/sh

set -e

echo "$INPUT_SERVICE_ACCOUNT_KEY" | base64 --decode > "$HOME"/gcloud.json

if [ -z "$INPUT_CONTEXT" ]; then
    INPUT_CONTEXT="."
fi

docker build -f "$INPUT_DOCKERFILE" -t "$INPUT_IMAGE" "$INPUT_CONTEXT"

gcloud auth activate-service-account --key-file="$HOME"/gcloud.json --project "$INPUT_PROJECT"

gcloud auth configure-docker

docker push $INPUT_IMAGE
