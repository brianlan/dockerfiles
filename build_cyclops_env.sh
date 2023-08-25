#!/bin/bash

tag=$1

if [ "$#" -ne 1 ]; then
  echo "Please provide <tag>"
  echo "Usage: $0 <tag> " >&2
  exit 1
fi

docker build -f dockerfiles/cyclops-env/Dockerfile -t $tag .
