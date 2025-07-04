FROM n8nio/n8n:latest
USER root

# Install Python3, pip, and build tools via Alpine’s apk
RUN apk update \
 && apk add --no-cache python3 py3-pip build-base openssl-dev libffi-dev \
 && ln -sf /usr/bin/python3 /usr/bin/python

# Install the MetaTrader5 package, overriding the PEP 668 restriction
RUN pip3 install MetaTrader5 --break-system-packages

# Copy in your fetch script
COPY mt5_fetch.py /data/mt5_fetch.py
RUN chmod +x /data/mt5_fetch.py

USER node
