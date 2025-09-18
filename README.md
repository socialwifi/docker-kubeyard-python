# What is this image

Base Python image that meets [kubeyard](https://pypi.org/project/kubeyard/) requirements. 

For more information, please read `kubeyard` documentation.

# How to use this image

Create a `Dockerfile` in your kubeyard project:

```dockerfile
FROM socialwifi/kubeyard-python

COPY requirements /requirements
RUN /usr/local/bin/install_requirements

COPY source /package
RUN pip install --no-deps --editable .
RUN mv *.egg-info $SITE_PACKAGES_DIR

CMD ["start_service"]
```

If you want to leverage Docker cache mounts, you can use the following example:
```dockerfile
# syntax=docker/dockerfile:1

FROM socialwifi/kubeyard-python

COPY requirements/apt.txt /requirements/
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    ENABLE_APT_CACHE="1" /usr/local/bin/install_apt_requirements
COPY requirements/python.txt /requirements/
RUN --mount=type=cache,target=/root/.cache/pip \
    ENABLE_PIP_CACHE="1" /usr/local/bin/install_pip_requirements

COPY source /package
RUN pip install --no-deps --editable .
RUN mv *.egg-info $SITE_PACKAGES_DIR

CMD ["start_service"]
```
More details about Docker cache mounts can be found [here](https://docs.docker.com/build/cache/optimize/#use-cache-mounts).

# Assumptions

## Helper scripts and variables

As can be seen in the above example, we are using some helper scripts and variables.
The important ones are:

Variables:
1. `SITE_PACKAGES_DIR` - directory where all packages are installed (follows 
the Python version)

Scripts:
1. `install_requirements` - script that installs all requirements (Python ones
with `pip` and system ones with `apt`) from `requirements` directory
2. `freeze_requirements` - script that generates the `requirements.txt` file
3. `run_tests` - script that runs code analysis and tests


## Static analysis

For static analysis we are using 
[flake8](https://pypi.org/project/flake8/) and 
[isort](https://pypi.org/project/isort/).

We are using `flake8` and `isort` separately due to code fixing - 
When isort is trying to fix imports it uses only own config files, `flake8` configs are omitted.

## Tests

We are using [pytest](https://pypi.org/project/pytest/) for running tests.

## Freezing requirements

We are using [pip-tools](https://pypi.org/project/pip-tools/) for freezing requirements - 
it gives much more readable output file with all dependencies listed.
