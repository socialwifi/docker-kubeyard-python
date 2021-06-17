#!/bin/bash
cd /package
echo "Fixing imports using isort..."
isort -v .
echo "Done!"
