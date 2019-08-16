#!/bin/sh

VERSION=$(grep -e "ARG CMATRIX_VERSION=" stable/Dockerfile)
VERSION=${VERSION#ARG CMATRIX_VERSION=\"}
VERSION=${VERSION%\"}
echo "Tagging version ${VERSION}"
docker tag "${DOCKER_USERNAME}/cmatrix:latest" "${DOCKER_USERNAME}/cmatrix:${VERSION}"
