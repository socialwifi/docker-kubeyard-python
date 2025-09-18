#!/bin/bash -e

APT_FILE="/requirements/apt.txt"
: ${ENABLE_APT_CACHE:="0"}

if [ -f "$APT_FILE" ]; then
    echo "Installing apt packages from $APT_FILE"
    apt-get update
    apt-get -y install $(cat "$APT_FILE")
    if [ "$ENABLE_APT_CACHE" = "0" ]; then
      rm -rf /var/lib/apt/lists/*
    fi
else
    echo "No apt.txt found, skipping apt package installation"
fi

echo "Requirements installation complete."
