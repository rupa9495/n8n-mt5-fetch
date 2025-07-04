FROM n8nio/n8n:latest
USER root

RUN apt-get update \
 && apt-get install -y python3 python3-pip build-essential libssl-dev \
 && rm -rf /var/lib/apt/lists/*

RUN pip3 install MetaTrader5

COPY mt5_fetch.py /data/mt5_fetch.py
RUN chmod +x /data/mt5_fetch.py

USER node
