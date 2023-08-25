#!/bin/bash

# tag=$1

# if [ "$#" -ne 1 ]; then
#   echo "Please provide <tag>"
#   echo "Usage: $0 <tag> " >&2
#   exit 1
# fi

tag="cyclops-env:cuda11.3-ubuntu20.04"
echo "Building Docker Image: ${tag}"

docker build -f dockerfiles/cyclops-env/Dockerfile -t cyclops-env:cuda11.3-ubuntu20.04 .
