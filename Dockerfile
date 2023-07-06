FROM debian:12-slim

LABEL maintainer="chris.bensch@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt -y upgrade && \
  apt -y --no-install-recommends install python3-minimal curl wget unzip gzip git tar pipx && \
  pipx install volatility3 && \
  pipx ensurepath && \
  apt -y autoremove && \
  apt -y autoclean && \
  rm -rf /var/lib/apt/lists/* && \
  git clone https://github.com/JPCERTCC/Windows-Symbol-Tables.git /tmp/JPCERT-Windows-Symbol-Tables && \
  cp -r /tmp/JPCERT-Windows-Symbol-Tables/symbols/windows /root/.local/pipx/venvs/volatility3/lib/python3.11/site-packages/volatility3/symbols/windows/ && \
  wget https://downloads.volatilityfoundation.org/volatility3/symbols/windows.zip -O /root/.local/pipx/venvs/volatility3/lib/python3.11/site-packages/volatility3/symbols/windows.zip && \
  wget https://downloads.volatilityfoundation.org/volatility3/symbols/mac.zip -O /root/.local/pipx/venvs/volatility3/lib/python3.11/site-packages/volatility3/symbols/mac.zip && \
  wget https://downloads.volatilityfoundation.org/volatility3/symbols/linux.zip -O /root/.local/pipx/venvs/volatility3/lib/python3.11/site-packages/volatility3/symbols/linux.zip && \
  cd /root/.local/pipx/venvs/volatility3/lib/python3.11/site-packages/volatility3/symbols/ && \
  unzip windows.zip && \
  unzip -d mac mac.zip && \
  unzip linux.zip && \
  rm *.zip

WORKDIR /data