FROM python:3.15.1-trixie@sha256:c5075348770d14159b316d99a4f65f3771d227710877021833119b014cd1a803

ENV PYTHONUNBUFFERED=1
ENV SITE_PACKAGES_DIR=/usr/local/lib/python3.15/site-packages

COPY bin /scripts
RUN cd /usr/local/bin && for f in /scripts/*; do ln -s "$f" $(basename "${f%.*}"); done

RUN pip install --upgrade --no-cache-dir \
    pip-tools==7.6.2 \
    flake8==7.4.1 \
    flake8-commas==4.0.0 \
    isort==9.0.2 \
    pytest==9.1.1 \
    setuptools==84.2.1 \
    pip==26.2.2

WORKDIR /package
