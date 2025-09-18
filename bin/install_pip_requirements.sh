#!/bin/bash -e

PYTHON_FILE="/requirements/python.txt"

if [ -f "$PYTHON_FILE" ]; then
    echo "Installing python packages from $PYTHON_FILE"
    pip install --no-cache-dir -r "$PYTHON_FILE"
else
    echo "No python.txt found, skipping pip package installation"
fi

echo "Requirements installation complete."
