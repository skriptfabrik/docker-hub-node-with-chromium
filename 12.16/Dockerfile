FROM node:12.16.1-alpine

ENV CHROME_BIN=/usr/bin/chromium-browser
ENV CHROME_DRIVER_BIN=/usr/bin/chromedriver
ENV CHROMIUM_VERSION=79.0.3945.130
ENV EUDEV_LIBS_VERSION=3.2.9
ENV TTF_OPENSANS_VERSION=1.10

RUN apk add --no-cache \
    chromium=${CHROMIUM_VERSION}-r0 \
    chromium-chromedriver=${CHROMIUM_VERSION}-r0 \
    eudev-libs=${EUDEV_LIBS_VERSION}-r1 \
    ttf-opensans=${TTF_OPENSANS_VERSION}-r0
