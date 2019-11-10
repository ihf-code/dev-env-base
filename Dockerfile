FROM amd64/debian:buster-slim

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
	apt-utils \
	dumb-init \
	bash \
	apt-transport-https \
	libxkbfile-dev \
	libsecret-1-dev \
	ca-certificates \
	locales \
	vim \
	git \
	tig \
	nano

ENV LC_ALL=en_US.UTF-8
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "LANG=en_US.UTF-8" >> /etc/locale.conf && \
    locale-gen en_US.UTF-8

RUN mkdir -p /usr/local/bin/ihfcode
COPY files/code-server/code-server /usr/local/bin/ihfcode
COPY files/ihfcode/* /usr/local/bin/ihfcode/
COPY files/etc/banner.txt /etc/banner.txt
COPY files/etc/skel/* /etc/skel/

RUN chmod 755 /usr/local/bin/ihfcode/*

RUN adduser --gecos '' --shell /bin/bash --disabled-password coder && \
    mkdir -p /home/coder/project && \
    mkdir -p /home/coder/.code-server/extensions && \
    mkdir -p /home/coder/.local/share/code-server/extensions && \
    mkdir -p /home/coder/.local/share/code-server/User && \
    cp /usr/local/bin/ihfcode/settings.json /home/coder/.local/share/code-server/User/settings.json && \
    chown coder:coder -R /home/coder

VOLUME [ "/home/coder/project" ]
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/ihfcode/bootstrap"]
