#!/bin/bash
cd /package
echo "Fixing imports using isort..."
isort -y
echo "Done!"
