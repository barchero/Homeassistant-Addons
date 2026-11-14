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

WORKDIR /app

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
