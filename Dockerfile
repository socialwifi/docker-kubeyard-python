FROM python:3.14.3-trixie@sha256:abc08a893f14b116d97079a69f1a8c0b5c33df65a7e5af8ff6356aa6d41d40aa

ENV PYTHONUNBUFFERED=1
ENV SITE_PACKAGES_DIR=/usr/local/lib/python3.14/site-packages

COPY bin /scripts
RUN cd /usr/local/bin && for f in /scripts/*; do ln -s "$f" $(basename "${f%.*}"); done

RUN pip install --upgrade --no-cache-dir \
    pip-tools==7.5.3 \
    flake8==7.3.0 \
    flake8-commas==4.0.0 \
    isort==7.0.0 \
    pytest==9.0.2 \
    setuptools==82.0.0 \
    pip==26.0.1

WORKDIR /package
