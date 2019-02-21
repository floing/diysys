FROM ubuntu:bionic
LABEL maintainer="haojunyu <haojunyu2012@gmail.com>"
LABEL version="1.0"
LABEL description="Base ubuntu:18.04LTS; For Common Coder"

# 换源
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak
ADD sources.list /
RUN mv /sources.list /etc/apt/sources.list
RUN apt-get update && apt list --upgradable

# common
RUN apt-get install -yq htop git wget \
                        libglib2.0-0 autoconf automake \
                        libtool build-essential unzip \
                        libarchive-dev vim

# configure vim
ADD vimrc /
RUN mv /vimrc ~/.vimrc

# Welcome message.
ADD welcome_message.txt /
RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd' \
        >> /etc/bash.bashrc \
        ; cat welcome_message.txt > /etc/motd

WORKDIR /home
