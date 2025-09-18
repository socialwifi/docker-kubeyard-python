#!/bin/bash -e

APT_FILE="/requirements/apt.txt"

if [ -f "$APT_FILE" ]; then
    echo "Installing apt packages from $APT_FILE"
    apt-get update && apt-get -y install $(cat "$APT_FILE") && rm -rf /var/lib/apt/lists/*
else
    echo "No apt.txt found, skipping apt package installation"
fi

echo "Requirements installation complete."
