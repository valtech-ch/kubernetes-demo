#!/usr/bin/env bash
IMAGE='valtech/kubernetes-demo-frontend'
VERSION=`latest`
sh logger.sh "Creating docker image ${IMAGE}:${VERSION}..."
docker build -t ${IMAGE}:${VERSION} ./
