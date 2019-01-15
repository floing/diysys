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

# just for faiss
RUN apt-get install -yq libopenblas-dev python-numpy swig curl libomp-dev
RUN pip install matplotlib
ENV BLASLDFLAGS /usr/lib/x86_64-linux-gnu/libopenblas.so.0

# download vowpal_wabbit and make install
WORKDIR /home
RUN git clone https://github.com/haojunyu/faiss.git && \
    cd faiss && \
    ./configure && \
    make && \
    make install && \
    make test && \
    pushd python && make install && popd
    

# Install Python dependencies.
ADD requirements.txt /home
RUN pip install --upgrade pip
RUN pip install -r requirements.txt


# Welcome message.
ADD welcome_message.txt /
RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd' \
        >> /etc/bash.bashrc \
        ; cat welcome_message.txt > /etc/motd

