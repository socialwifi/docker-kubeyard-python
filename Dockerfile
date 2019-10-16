FROM python:3.8.0@sha256:dcae8a0759da45d4ec674d743cea068d8eb1d2a07db406bef7a17df3761694a8
ENV PYTHONUNBUFFERED 1
RUN mkdir /package
WORKDIR /package
COPY bin /scripts
RUN cd /usr/local/bin && for f in /scripts/*; do ln -s "$f" $(basename "${f%.*}"); done
RUN pip install --upgrade --no-cache-dir \
    pip-tools==3.4.0 \
    flake8==3.7.7 \
    flake8-commas==2.0.0 \
    isort==4.3.15 \
    pytest==3.8.1
COPY ./code_style_config /root
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
