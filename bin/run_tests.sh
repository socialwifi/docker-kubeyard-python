#!/bin/bash
cd /package
PYTHONPATH=. pytest -p no:cacheprovider "$@" || ERROR=1
check_code_style || ERROR=1
exit $ERROR
