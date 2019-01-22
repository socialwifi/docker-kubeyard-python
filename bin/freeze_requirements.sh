#!/bin/bash -e
pip-compile --rebuild --verbose --output-file /requirements/python.txt /package/base_requirements.txt
