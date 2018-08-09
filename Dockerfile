FROM googlecontainer/ubuntu-slim:0.6

MAINTAINER Lorenzo Salvadorini (lorello) <lorello@openweb.it>

ENV MYDUMPER_VERSION 0.9.5-2.xenial_amd64

WORKDIR /tmp

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    libglib2.0-0 \
    libmysqlclient-dev \
    libssl-dev \
    moreutils \
    wget \
  \
  && cd /tmp \
  && wget --quiet https://github.com/maxbube/mydumper/releases/download/v0.9.5/mydumper_${MYDUMPER_VERSION}.deb \
  && dpkg -i mydumper_${MYDUMPER_VERSION}.deb \
  && rm -f /tmp/mydumper_${MYDUMPER_VERSION}.deb \
  && apt-get purge -y ca-certificates wget \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /usr/share/{doc,man}/* \
  && rm -rf /var/lib/apt/lists/*

#ADD mydumper.sh /usr/local/bin/mydumper
#ADD myloader.sh /usr/local/bin/myloader

WORKDIR /var/tmp

ENTRYPOINT [ "/usr/bin/mydumper" ]

CMD [ "--version" ]


