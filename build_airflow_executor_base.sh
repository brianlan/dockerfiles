#!/bin/bash

ver="0.0.1"

if [ "$#" -ne 1 ]; then
  echo "Please provide <version>"
  echo "Usage: $0 <version> " >&2
  exit 1
fi

ver=$1
tag="airflow-executor-base:${ver}"

echo "Building Docker Image: ${tag}"

docker build -f dockerfiles/airflow-executor-base/Dockerfile -t ${tag} .
