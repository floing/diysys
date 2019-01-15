FROM ubuntu:latest
LABEL maintainer="haojunyu <haojunyu2012@gmail.com>"
LABEL version="1.0"
LABEL description="Used to familiarize with vowpal_wabbit"

# common
RUN apt update && apt install -yq \
                        python2.7 python-pip htop git wget \
                        libglib2.0-0 autoconf automake \
                        libtool build-essential unzip \
                        libarchive-dev vim

# just for vowpal_wabbit
RUN apt install -yq libboost-program-options-dev libboost-python-dev\
                        zlib1g-dev

# download vowpal_wabbit and make install
WORKDIR /home
RUN git clone https://github.com/haojunyu/vowpal_wabbit.git && \
    cd vowpal_wabbit && \
    make && \
    make test && \
    make install

# Install Python dependencies.
ADD requirements.txt /home
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

RUN echo 'export  LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib' \
  >> ~/.bashrc
RUN echo 'export  PATH=$PATH:/home/vowpal_wabbit/utl/' \
  >> ~/.bashrc

# Welcome message.
ADD welcome_message.txt /
RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd' \
        >> /etc/bash.bashrc \
        ; cat welcome_message.txt > /etc/motd

