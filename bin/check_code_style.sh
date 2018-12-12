#!/bin/bash
cd /package
echo "Running flake8..."
PYTHONWARNINGS="ignore::FutureWarning:pycodestyle" flake8 || ERROR=1
echo "Running isort..."
isort -c || ERROR=1

if [ $ERROR ]; then
    echo -e "\e[31mYour code is dirty!\e[0m"
else
    echo -e "\e[32mDone.\e[0m"
fi
exit $ERROR
