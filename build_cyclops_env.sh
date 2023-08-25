#!/bin/bash

# tag=$1

if [ "$#" -ne 1 ]; then
  echo "Please provide cuda version: [cu110, cu113]"
  echo "Usage: $0 <cuda_version> " >&2
  exit 1
fi

cuda_version=$1

if [ "${cuda_version}" = "cu110" ] || [ "${cuda_version}" = "cu113" ]; then
  echo "target cuda version is ${cuda_version}"
else
  echo "Invalid cuda version"
  exit 1
fi

tag="cyclops-env:${cuda_version}-ubuntu20.04"

echo "Building Docker Image: ${tag}"

docker build -f dockerfiles/cyclops-env/Dockerfile-${cuda_version} -t ${tag} .
