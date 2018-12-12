#!/bin/bash -e
pip-compile --rebuild --verbose --output-file requirements.txt - 1>&2
cat requirements.txt
