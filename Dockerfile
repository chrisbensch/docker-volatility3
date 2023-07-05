FROM debian:12-slim

LABEL maintainer="chris.bensch@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt -y upgrade && \
  apt -y --no-install-recommends install python3-minimal curl wget unzip gzip tar pipx && \
  pipx install volatility3 && \
  pipx ensurepath && \
  apt -y autoremove && \
  apt -y autoclean && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /data