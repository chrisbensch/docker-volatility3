FROM debian:11.1-slim

LABEL maintainer="chris.bensch@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt -y upgrade && \
  apt -y --no-install-recommends install python3 python3-pip git build-essential python3-dev curl wget unzip gzip tar && \
  apt -y autoremove && \
  apt -y autoclean && \
  rm -rf /var/lib/apt/lists/*

RUN pip install pycrypto distorm3 openpyxl ujson volatility3

WORKDIR /usr/lib

# Build the Python bindings for YARA
RUN git clone --recursive https://github.com/VirusTotal/yara-python && \
  cd yara-python && \
  python3 setup.py build

WORKDIR /usr/local/lib/python3.9/dist-packages/volatility3/symbols/

# Fetch the symbols from the Volatility Fondation and JPCERTCC
RUN curl -fL https://downloads.volatilityfoundation.org/volatility3/symbols/linux.zip -o linux.zip && \
  unzip linux.zip && \
  curl -fL https://downloads.volatilityfoundation.org/volatility3/symbols/mac.zip -o mac.zip && \
  mkdir mac && \
  unzip mac.zip -d mac && \
  curl -fL https://downloads.volatilityfoundation.org/volatility3/symbols/windows.zip -o windows.zip && \
  unzip windows.zip && \
  git clone https://github.com/JPCERTCC/Windows-Symbol-Tables.git /tmp/Windows-Symbol-Tables && \
  mv /tmp/Windows-Symbol-Tables/symbols/windows/ntkrnlmp.pdb/* /usr/local/lib/python3.9/dist-packages/volatility3/symbols/windows/ntkrnlmp.pdb/ && \
  rm *.zip && \
  rm -rf /tmp/Windows-Symbol-Tables

# Final Cleanup
RUN apt -y autoremove && apt -y autoclean && rm -rf /var/lib/apt/lists/*

WORKDIR /data