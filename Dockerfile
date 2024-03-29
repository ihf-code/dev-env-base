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
	nano \
	bsdtar \
	sudo \
	figlet

ENV LC_ALL=en_US.UTF-8
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "LANG=en_US.UTF-8" >> /etc/locale.conf && \
    locale-gen en_US.UTF-8

RUN mkdir -p /usr/local/bin/code-env/extensions

COPY files/extensions/* /usr/local/bin/code-env/extensions/
COPY files/code-server/code-server /usr/local/bin/code-env
COPY files/code-env/* /usr/local/bin/code-env/
COPY files/etc/banner.txt /etc/banner.txt
COPY files/etc/skel/* /etc/skel/

RUN chmod 755 /usr/local/bin/code-env/* && \
    chmod 777 /usr/local/bin/code-env/extensions

RUN adduser --gecos '' --shell /bin/bash --disabled-password coder && \
    mkdir -p /home/coder/project && \
    mkdir -p /home/coder/.local/share/code-server/User && \
    mkdir -p /home/coder/.code-server/extensions && \
    mkdir -p /home/coder/.local/share/code-server/extensions && \
    cp /usr/local/bin/code-env/settings.json /home/coder/.local/share/code-server/User/settings.json && \
    chown coder:coder -R /home/coder

RUN echo "coder         ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers

VOLUME [ "/home/coder/project" ]
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/code-env/bootstrap"]
