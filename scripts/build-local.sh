#!/usr/bin/env bash
set -e

REGISTRY="ghcr.io/cognivyn"
TAG="${2:-latest}"
TARGET="${1:-all}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

build_image() {
    local IMAGE_NAME="$1"
    local DOCKERFILE_PATH="${ROOT_DIR}/${IMAGE_NAME}/Dockerfile"

    if [ ! -f "$DOCKERFILE_PATH" ]; then
        echo "❌ Error: Dockerfile not found at ${DOCKERFILE_PATH}"
        exit 1
    fi

    # Extract the default BASE_IMAGE from the Dockerfile's ARG line so the local
    # build uses the correct parent (e.g. base-bun for base-bun-infisical).
    local BASE_IMAGE_DEFAULT
    BASE_IMAGE_DEFAULT=$(grep -oP '^ARG BASE_IMAGE=\K\S+' "$DOCKERFILE_PATH" | head -1)

    if [ -n "$BASE_IMAGE_DEFAULT" ]; then
        local BASE_IMAGE_TAGGED="${BASE_IMAGE_DEFAULT/:latest/:${TAG}}"
        if [ "$BASE_IMAGE_DEFAULT" = "$BASE_IMAGE_TAGGED" ]; then
            BASE_IMAGE_TAGGED="${BASE_IMAGE_DEFAULT}:${TAG}"
        fi
        echo "🐳 Building ${REGISTRY}/${IMAGE_NAME}:${TAG} (FROM ${BASE_IMAGE_TAGGED})..."
        docker build \
            --build-arg BASE_IMAGE="${BASE_IMAGE_TAGGED}" \
            -t "${REGISTRY}/${IMAGE_NAME}:${TAG}" \
            -f "$DOCKERFILE_PATH" \
            "${ROOT_DIR}/${IMAGE_NAME}"
    else
        echo "🐳 Building ${REGISTRY}/${IMAGE_NAME}:${TAG}..."
        docker build \
            -t "${REGISTRY}/${IMAGE_NAME}:${TAG}" \
            -f "$DOCKERFILE_PATH" \
            "${ROOT_DIR}/${IMAGE_NAME}"
    fi
    echo "✅ Successfully built ${REGISTRY}/${IMAGE_NAME}:${TAG}"
}

if [ "$TARGET" = "all" ]; then
    build_image "base-runtime"
    build_image "base-node"
    build_image "base-python"
    build_image "base-bun"
    build_image "base-php"
    build_image "base-bun-infisical"
else
    build_image "$TARGET"
fi
