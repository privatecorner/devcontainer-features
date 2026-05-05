#!/bin/bash
set -e

VERSION=${VERSION:-main}

# ensure_pipx: make sure Python 3 and pipx are available before using uv.
# If pipx is already present, nothing more needs to be done.
# Otherwise on Debian/Ubuntu systems this installs python3 and pipx.
ensure_pipx() {
    if command -v pipx >/dev/null 2>&1; then
        return
    fi

    if command -v apt-get >/dev/null 2>&1; then
        apt-get update
        apt-get install -y pipx
        return
    fi

    echo "Could not install Python: unsupported package manager." >&2
    exit 1
}

# ensure_git: make sure git isavailable.
ensure_git() {
    if command -v git >/dev/null 2>&1; then
        return
    fi

    if command -v apt-get >/dev/null 2>&1; then
        apt-get install -y git
        return
    fi

    echo "Could not install git: unsupported package manager." >&2
    exit 1
}

## Run the installer helper for uv and git before attempting to install specify-cli.
ensure_pipx
ensure_git

INSTALL_SOURCE="git+https://github.com/github/spec-kit.git@$VERSION"
echo "Installing specify-cli from $INSTALL_SOURCE"

# Install the specify CLI from the requested source using pipx.
PIPX_HOME=/opt/pipx PIPX_BIN_DIR=/usr/local/bin pipx install $INSTALL_SOURCE --force

# Verify that the specify binary is now available on PATH.
if ! command -v specify >/dev/null 2>&1; then
    echo "Failed to install specify CLI to PATH." >&2
    exit 1
fi

echo "Installed Spec Kit Specify CLI"
