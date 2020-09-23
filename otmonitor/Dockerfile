# ARG BUILD_FROM=hassioaddons/base:8.0.3
# FROM ${BUILD_FROM}

FROM python:3.6

RUN apt-get update \
  && apt-get install -y wget python3-tk \
  && rm -rf /var/lib/apt/lists/*

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
ARG BUILD_ARCH
RUN \
    mkdir /app \
    && if [[ "${BUILD_ARCH}" = "aarch64" ]]; then ARCH="-aarch64"; fi \
    && if [[ "${BUILD_ARCH}" = "amd64" ]]; then ARCH="-x64"; fi \
    && if [[ "${BUILD_ARCH}" = "armhf" ]]; then ARCH="-ahf"; fi \
    && if [[ "${BUILD_ARCH}" = "armv7" ]]; then ARCH="-ahf"; fi \
    && if [[ "${BUILD_ARCH}" = "i386" ]]; then ARCH=""; fi \
    \
    && curl -L -s -o "/app/otmonitor" "http://otgw.tclcode.com/download/otmonitor${ARCH}" \
    && chmod a+x /app/otmonitor

CMD ["/app/otmonitor", "--daemon", "-f", "/share/otmonitor/otmonitor.conf"]

# Build arguments
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="OpenTherm Monitor" \
    io.hass.description="The OpenTherm Monitor helps you configure and monitor your opentherm gateway" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Bas Schipper <basschipper@users.noreply.github.com>"
