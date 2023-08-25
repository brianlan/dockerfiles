#!/bin/bash

# tag=$1

# if [ "$#" -ne 1 ]; then
#   echo "Please provide <tag>"
#   echo "Usage: $0 <tag> " >&2
#   exit 1
# fi

tag="airflow-executor-base:0.0.1"
echo "Building Docker Image: ${tag}"

docker build -f dockerfiles/airflow-executor-base/Dockerfile -t ${tag}.
