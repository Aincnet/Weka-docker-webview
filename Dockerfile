FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    wget \
    unzip \
    openjdk-11-jre \
    xvfb \
    fluxbox \
    x11vnc \
    novnc \
    websockify \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt

WORKDIR /opt

RUN wget https://downloads.sourceforge.net/project/weka/weka-3-8/3.8.6/weka-3-8-6.zip \
    && unzip weka-3-8-6.zip \
    && mv weka-3-8-6 weka \
    && rm weka-3-8-6.zip

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 6080

CMD ["/start.sh"]
