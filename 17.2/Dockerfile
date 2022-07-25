FROM node:17.2.0-alpine

ENV CHROME_BIN=/usr/bin/chromium-browser
ENV CHROME_DRIVER_BIN=/usr/bin/chromedriver
ENV CHROMIUM_VERSION=93.0.4577.82
ENV EUDEV_LIBS_VERSION=3.2.10
ENV TTF_OPENSANS_VERSION=1.10

RUN apk add --no-cache \
    chromium=${CHROMIUM_VERSION}-r0 \
    chromium-chromedriver=${CHROMIUM_VERSION}-r0 \
    eudev-libs=${EUDEV_LIBS_VERSION}-r0 \
    ttf-opensans=${TTF_OPENSANS_VERSION}-r1
