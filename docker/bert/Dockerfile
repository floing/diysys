FROM ubuntu:bionic
LABEL maintainer="haojunyu <haojunyu2012@gmail.com>"
LABEL version="1.0"
LABEL description="Base ubuntu:18.04LTS; For Common Coder"

# 换源
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak
ADD sources.list /
RUN mv /sources.list /etc/apt/sources.list
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tk-dev \
  && rm -rf /var/lib/apt/lists/*

# common
RUN apt-get install -yq htop git wget \
                        libglib2.0-0 autoconf automake \
                        libtool build-essential unzip \
                        libarchive-dev vim

# bert
RUN apt install python3-dev python3-pip  && pip3 install --user --upgrade tensorflow 
# configure vim
ADD vimrc /
RUN mv /vimrc ~/.vimrc

# Welcome message.
ADD welcome_message.txt /
RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd' \
        >> /etc/bash.bashrc \
        ; cat welcome_message.txt > /etc/motd

WORKDIR /home
