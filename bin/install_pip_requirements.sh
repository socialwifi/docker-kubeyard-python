#!/bin/bash -e

PYTHON_FILE="/requirements/python.txt"
: ${ENABLE_PIP_CACHE:="0"}
if [ "$ENABLE_PIP_CACHE" = "1" ]; then
  PIP_CACHE_ARG=""
else
  PIP_CACHE_ARG="--no-cache-dir"
fi

if [ -f "$PYTHON_FILE" ]; then
    echo "Installing python packages from $PYTHON_FILE"
    pip install $PIP_CACHE_ARG -r "$PYTHON_FILE"
else
    echo "No python.txt found, skipping pip package installation"
fi

echo "Requirements installation complete."
