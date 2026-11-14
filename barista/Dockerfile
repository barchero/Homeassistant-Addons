ARG BUILD_FROM
FROM ${BUILD_FROM}

ARG BARISTA_REPO=https://github.com/asaf5767/barista.git
ARG BARISTA_REF=master

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Fetch the barista source and install it. Build deps are removed afterwards.
RUN apk add --no-cache --virtual .build-deps git build-base \
    && git clone --depth 1 --branch "${BARISTA_REF}" "${BARISTA_REPO}" /app \
    && rm -rf /app/.git \
    && pip install -e /app \
    && apk del .build-deps

# /data is the add-on's persistent storage: keep auto-brew schedules there
RUN ln -s /data/auto_brew_schedules.json /app/barista/auto_brew_schedules.json

# Ingress serves the UI under /api/hassio_ingress/<token>/, so make the UI call
# the API relative to the page path instead of the site root ("/api/...").
# Fails the build if upstream changes that line, instead of shipping a broken UI.
RUN sed -i "s#const API = '';#const API = window.location.pathname.replace(/\\\\/\$/, '');#" /app/barista/ui/index.html \
    && grep -q "const API = window.location.pathname" /app/barista/ui/index.html

WORKDIR /app

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
