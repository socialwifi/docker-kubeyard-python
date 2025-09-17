FROM python:3.12.11@sha256:1cb6108b64a4caf2a862499bf90dc65703a08101e8bfb346a18c9d12c0ed5b7e

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
