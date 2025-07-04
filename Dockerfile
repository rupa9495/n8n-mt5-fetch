FROM n8nio/n8n:latest
USER root

# 1. Install Python3, pip, and build tools via Alpine’s apk
RUN apk update \
 && apk add --no-cache python3 py3-pip build-base openssl-dev libffi-dev \
 && ln -sf /usr/bin/python3 /usr/bin/python

# 2. Install the MetaTrader5 package
RUN pip3 install MetaTrader5

# 3. Copy in your fetch script
COPY mt5_fetch.py /data/mt5_fetch.py
RUN chmod +x /data/mt5_fetch.py

USER node
