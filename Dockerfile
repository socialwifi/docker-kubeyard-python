FROM python:3.12.1@sha256:c50322f5f9b2a3b7ac68dc3cf03e5b29d7f51faa58b8321d975f028eb0c00a73
ENV PYTHONUNBUFFERED 1
RUN mkdir /package
WORKDIR /package
COPY bin /scripts
RUN cd /usr/local/bin && for f in /scripts/*; do ln -s "$f" $(basename "${f%.*}"); done
RUN pip install --upgrade --no-cache-dir \
    pip-tools==7.3.0 \
    flake8==6.1.0 \
    flake8-commas==2.1.0 \
    isort==5.13.0 \
    pytest==7.4.3
ARG PIP_EXTRA_INDEX_URL
ENV PIP_EXTRA_INDEX_URL $PIP_EXTRA_INDEX_URL
ONBUILD COPY requirements /requirements
ONBUILD RUN bash -c 'if [ -f "/requirements/apt.txt" ]; then apt-get update && \
                     apt-get -y install $(cat /requirements/apt.txt) && \
                     rm -rf /var/lib/apt/lists/*; fi'
ONBUILD RUN bash -c 'if [ -f "/requirements/python.txt" ]; then pip install --no-cache-dir -r /requirements/python.txt; fi'
ONBUILD COPY source /package
ONBUILD RUN pip install --no-deps --editable .
ONBUILD RUN bash -c 'mv *.egg-info $(python -c "import site; print(site.getsitepackages()[0])")'
ONBUILD RUN python setup.py clean
