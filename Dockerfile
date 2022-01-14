# Ubuntu Focal 20.04
# Swift 5.5.2 Release
FROM ubuntu:20.04

#ENV ARCH=`uname -m`

RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true && apt-get -q update && \
    apt-get -q install -y \
    wget

#ARG PACKAGE_NAME=swiftlang_5.5.2-01-ubuntu-focal_$ARCH.deb
ARG RELEASE_TAG=v5.5.2-RELEASE
ARG SWIFT_WEBROOT=https://archive.swiftlang.xyz/repos/ubuntu/pool/main/s/swiftlang

RUN echo `dpkg --print-architecture`

RUN set -e; \
   ARCH= && dpkgArch="$(dpkg --print-architecture)" \
    && case "${dpkgArch##*-}" in \
      amd64) ARCH='amd64';; \
      arm64) ARCH='arm64';; \
      aarch64) ARCH='arm64';; \
      *) echo "unsupported architecture"; exit 1 ;; \
    esac \
    SWIFT_BIN_URL="$SWIFT_WEBROOT/swiftlang_5.5.2-01-ubuntu-focal_$ARCH.deb" \
    # - download the swift toolchain
    && wget "$SWIFT_BIN_URL" \
    # - install swift
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -q install -y ./"$PACKAGE_NAME" \
    # - clean up.
    && rm -rf "$PACKAGE_NAME" \
    && apt-get purge --auto-remove -y wget \
    && rm -r /var/lib/apt/lists/*

# Print Installed Swift Version
RUN swift --version