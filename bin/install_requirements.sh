#!/bin/bash -e

APT_FILE="/requirements/apt.txt"
PYTHON_FILE="/requirements/python.txt"

if [ -f "$APT_FILE" ]; then
    echo "Installing apt packages from $APT_FILE"
    apt-get update && apt-get -y install $(cat "$APT_FILE") && rm -rf /var/lib/apt/lists/*
else
    echo "No apt.txt found, skipping apt package installation"
fi
if [ -f "$PYTHON_FILE" ]; then
    echo "Installing python packages from $PYTHON_FILE"
    pip install --no-cache-dir -r "$PYTHON_FILE"
else
    echo "No python.txt found, skipping pip package installation"
fi

echo "Requirements installation complete."
