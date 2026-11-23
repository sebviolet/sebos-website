#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Builds the FrenchFamily Hugo site for Cloudflare Workers.
#------------------------------------------------------------------------------

set -euo pipefail

build_temp_dir=""

cleanup() {
  if [[ -n "${build_temp_dir:-}" && -d "${build_temp_dir}" ]]; then
    rm -rf "${build_temp_dir}"
  fi
}

trap cleanup EXIT SIGINT SIGTERM

main() {
  DART_SASS_VERSION=1.108.2
  GO_VERSION=1.27.4
  HUGO_VERSION=0.170.1
  NODE_VERSION=26.13.1

  export TZ=Europe/Paris
  export HUGO_CACHEDIR="${PWD}/.cache/hugo"

  build_temp_dir=$(mktemp -d)
  pushd "${build_temp_dir}" > /dev/null

  mkdir -p "${HOME}/.local"

  echo "Installing Dart Sass ${DART_SASS_VERSION}..."
  curl -sLJO "https://github.com/sass/dart-sass/releases/download/${DART_SASS_VERSION}/dart-sass-${DART_SASS_VERSION}-linux-x64.tar.gz"
  tar -C "${HOME}/.local" -xf "dart-sass-${DART_SASS_VERSION}-linux-x64.tar.gz"
  export PATH="${HOME}/.local/dart-sass:${PATH}"

  echo "Installing Go ${GO_VERSION}..."
  curl -sLJO "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"
  tar -C "${HOME}/.local" -xf "go${GO_VERSION}.linux-amd64.tar.gz"
  export PATH="${HOME}/.local/go/bin:${PATH}"

  echo "Installing Hugo ${HUGO_VERSION}..."
  curl -sLJO "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_linux-amd64.tar.gz"
  mkdir -p "${HOME}/.local/hugo"
  tar -C "${HOME}/.local/hugo" -xf "hugo_${HUGO_VERSION}_linux-amd64.tar.gz"
  export PATH="${HOME}/.local/hugo:${PATH}"

  echo "Installing Node.js ${NODE_VERSION}..."
  curl -sLJO "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz"
  tar -C "${HOME}/.local" -xf "node-v${NODE_VERSION}-linux-x64.tar.xz"
  export PATH="${HOME}/.local/node-v${NODE_VERSION}-linux-x64/bin:${PATH}"

  popd > /dev/null

  echo "Verifying installations..."
  echo "Dart Sass: $(sass --version)"
  echo "Go: $(go version)"
  echo "Hugo: $(hugo version)"
  echo "Node.js: $(node --version)"

  if [ -d ".git" ]; then
    git config core.quotepath false
    if [ "$(git rev-parse --is-shallow-repository)" = "true" ]; then
      git fetch --unshallow
    fi
  fi

  echo "Building the site..."
  hugo build --gc --minify
}

main "$@"
