# AUTHOR:         João Ribeiro <jonnybgod@gmail.com>
# DESCRIPTION:    jonnybgod/topbeat

FROM phusion/baseimage:latest
MAINTAINER João Ribeiro <jonnybgod@gmail.com>

ENV VERSION=1.1.2 PLATFORM=x86_64
ENV FILENAME=topbeat-${VERSION}-${PLATFORM}.tar.gz 

RUN apt-get update \
 && apt-get install -y --no-install-recommends libpcap0.8 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -L -O https://download.elastic.co/beats/topbeat/${FILENAME} \
 && tar xzvf ${FILENAME}

ADD topbeat.yml /etc/topbeat/topbeat.yml

WORKDIR topbeat-${VERSION}-${PLATFORM}

CMD ["./topbeat", "-e", "-c=/etc/topbeat/topbeat.yml"]