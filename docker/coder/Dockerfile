FROM ubuntu:latest
LABEL maintainer="haojunyu <haojunyu2012@gmail.com>"
LABEL version="2.0"
LABEL description="Base ubuntu:18.04LTS; For Common Coder"

# common
RUN apt-get update && apt-get install -yq \
                        python2.7 python-pip htop git wget \
                        libglib2.0-0 autoconf automake \
                        libtool build-essential unzip \
                        libarchive-dev vim

# nvm,node,npm安装
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
source ~/.bashrc
nvm install node

# configure vim
ADD vimrc /
RUN mv /vimrc ~/.vimrc

# Welcome message.
ADD welcome_message.txt /
RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd' \
        >> /etc/bash.bashrc \
        ; cat welcome_message.txt > /etc/motd

WORKDIR /home
