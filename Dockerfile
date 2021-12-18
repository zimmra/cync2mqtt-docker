FROM alpine:3.15

ENV LANG="C.UTF-8" \
    PS1="$(whoami)@$(hostname):$(pwd)$ " \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    S6_CMD_WAIT_FOR_SERVICES=1 \
    TERM="xterm-256color"
    
COPY . /app/cync2mqtt
RUN apk add --no-cache git gcc libc-dev python3 bluez py3-pip py3-virtualenv py3-setuptools py3-wheel py3-docopt py3-websockets py3-passlib py3-coveralls py3-pycryptodome curl && \
    # APKARCH="$(apk --print-arch)" && \
    # case "${APKARCH}" in \
    #     aarch64|armhf) \
    #         S6ARCH="${APKARCH}";; \
    #     x86_64) \
    #         S6ARCH="amd64";; \
    #     armv7) \
    #         S6ARCH="arm";; \
    #     *) \
    #         echo >&2 "ERROR: Unsupported architecture '$APKARCH'" \
    #         exit 1;; \
    # esac && \
    pip3 install pyyaml==5.4.1 && \
    #curl -L -s "https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.3/s6-overlay-${S6ARCH}.tar.gz" | tar zxf - -C / && \
    # mkdir -p /etc/fix-attrs.d && \
    # mkdir -p /etc/services.d && \
    # #cp -a /app/cync2mqtt/init/s6/* /etc/. && \
    # rm -Rf /app/cync2mqtt/init && \ 
    # case "${APKARCH}" in \
    #     x86_64) \
    #         RSSARCH="amd64";; \
    #     aarch64) \
    #         RSSARCH="arm64v8";; \
    #     armv7) \
    #         RSSARCH="armv7";; \
    #     armhf) \
    #         RSSARCH="armv6";; \
    #     *) \
    #         echo >&2 "ERROR: Unsupported architecture '$APKARCH'" \
    #         exit 1;; \
    # esac && \
    python3 -mvenv ~/venv/cync2mqtt && ~/venv/cync2mqtt/bin/pip3 install git+https://github.com/juanboro/cync2mqtt.git && \
    curl -J -L -o /tmp/bashio.tar.gz "https://github.com/hassio-addons/bashio/archive/v0.13.1.tar.gz" && \
    mkdir /tmp/bashio && \
    tar zxvf /tmp/bashio.tar.gz --strip 1 -C /tmp/bashio && \
    mv /tmp/bashio/lib /usr/lib/bashio && \
    ln -s /usr/lib/bashio/bashio /usr/bin/bashio && \
    mkdir /data && \
    chmod 777 /data /app /run && \
    rm -f -r /tmp/*
ENTRYPOINT [ "/init" ]

ARG BUILD_VERSION
ARG BUILD_DATE

LABEL \
    io.hass.name="Cync Device Integration via MQTT" \
    io.hass.description="Home Assistant Community Add-on for Cync Devices" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Zimmra <paytonz@icloud.com>" \
    org.opencontainers.image.title="Cync Device Integration via MQTT" \
    org.opencontainers.image.description="Home Assistant Community Add-on for Cync Devices" \
    org.opencontainers.image.authors="Zimmra <paytonz@icloud.com> (and various other contributors)" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/zimmra/cync2mqtt-docker" \
    org.opencontainers.image.documentation="https://github.com/zimmra/cync2mqtt/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.version=${BUILD_VERSION}
