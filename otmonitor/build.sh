#!/bin/sh

NAME=$(grep "name" build.config | cut -d '=' -f2)
VERSION=$(grep "version" build.config | cut -d '=' -f2)
IMAGE="${NAME}:${VERSION}"

image() {
  echo "Build image ${IMAGE}"
  docker build \
    --build-arg BUILD_ARCH=amd64 \
    --build-arg BUILD_VERSION=${VERSION} \
    --tag ${IMAGE} \
    --force-rm \
    .
}

push() {
  echo "Push image ${IMAGE}"
  docker push ${IMAGE}
}

help() {
  echo "Usage: ./build.sh <function>"
  echo ""
  echo "Functions"
  printf "   \033[36m%-30s\033[0m %s\n" "image" "Build the Docker image."
  printf "   \033[36m%-30s\033[0m %s\n" "push" "Push the Docker image."
  echo ""
  echo "Content of build.config"
  printf "   \033[36m%-30s\033[0m %s\n" "name=<name>" "Name of the Docker image, required."
  printf "   \033[36m%-30s\033[0m %s\n" "version=<version>" "Version of the Docker image, required."
  echo ""
}

if [ -z "${1}" ]; then
  echo "ERROR: function required"
  help
  exit 1
fi
${1}
