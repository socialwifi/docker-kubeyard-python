# KUBEYARD PYTHON IMAGE

Basic python image that meets [kubeyard](https://pypi.org/project/kubeyard/) requirements. 

For more info, please read `kubeyard` documentation! 


## Advanced usage

If you want to allow downloading packages from own pypi for all images built on this image, 
you need to run: 

```bash
docker build -t kubeyard-python:own_pypi --build-arg PIP_EXTRA_INDEX_URL=https://username:password@pypi.example.com .
```

## Assumptions

### Static analysis

For static analysis we are using 
[flake8](https://pypi.org/project/flake8/) and 
[isort](https://pypi.org/project/isort/).

We are using `flake8` and `isort` separately due to code fixing - 
When isort is trying to fix imports it uses only own config files, `flake8` configs are omitted.

### Tests

We are using [pytest](https://pypi.org/project/pytest/) for running tests.

### Freezing requirements

We are decided to use [pip-tools](https://pypi.org/project/pip-tools/) for freezing requirements - 
it gives much more readable output file with all dependencies listed.
