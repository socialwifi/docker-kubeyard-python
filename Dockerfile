FROM python:3.12.1@sha256:c50322f5f9b2a3b7ac68dc3cf03e5b29d7f51faa58b8321d975f028eb0c00a73

ENV PYTHONUNBUFFERED=1
ENV SITE_PACKAGES_DIR=/usr/local/lib/python3.12/site-packages/

COPY bin /scripts
RUN cd /usr/local/bin && for f in /scripts/*; do ln -s "$f" $(basename "${f%.*}"); done

RUN pip install --upgrade --no-cache-dir \
    pip-tools==7.3.0 \
    flake8==6.1.0 \
    flake8-commas==2.1.0 \
    isort==5.13.0 \
    pytest==7.4.3

WORKDIR /package
