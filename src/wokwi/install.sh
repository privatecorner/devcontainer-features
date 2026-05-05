#!/bin/sh
set -e

echo "Activating feature 'wokwi'"

# Install Wokwi CLI into /opt by default.
export WOKWI_CLI_INSTALL=${WOKWI_CLI_INSTALL:-/opt}

if ! command -v curl >/dev/null 2>&1; then
	echo "curl not found; checking for package manager to install it..."
	if command -v apt-get >/dev/null 2>&1; then
		apt-get update
		apt-get install -y curl
	else
		echo "ERROR: curl not found, no supported package manager available." >&2
		exit 1
	fi
fi


curl -L https://wokwi.com/ci/install.sh | sh

# Ensure the CLI is available on PATH for the container.
ln -sfn "$WOKWI_CLI_INSTALL/bin/wokwi-cli" /usr/local/bin/wokwi-cli

echo "Wokwi CLI installed to $WOKWI_CLI_INSTALL/bin/wokwi-cli"