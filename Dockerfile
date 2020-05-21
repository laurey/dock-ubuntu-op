FROM ubuntu:18.04

ENV TERM="xterm-256color"

LABEL maintainer="lao"

# RUN cat /etc/apt/sources.list | grep -v "#"
 
RUN apt-get update && apt-get upgrade -y && apt-get install -y dialog apt-utils build-essential sudo curl wget \
  ca-certificates software-properties-common zlib1g-dev python3.5 python2.7 apt-transport-https unzip p7zip p7zip-full \
  uglifyjs upx subversion msmtp bzip2 binutils gawk

RUN apt-get install -y git git-core texinfo gcc-multilib autoconf automake gettext libtool autopoint flex g++-multilib

RUN sh -c 'echo "deb http://archive.canonical.com/ubuntu/ bionic partner" >> \
/etc/apt/sources.list.d/canonical_partner.list' 

RUN add-apt-repository ppa:ubuntu-desktop/ppa

# RUN apt-get update && apt-get -y upgrade

# config env
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.utf8

# RUN lscpu | egrep 'Model name|Socket|Thread|NUMA|CPU\(s\)'

# update & install packages
# RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get -y install libncurses5-dev \
#   libz-dev lib32gcc1 libc6-dev-i386 libssl-dev libglib2.0-dev libelf-dev && unset DEBIAN_FRONTEND
RUN apt-get update && apt-get -y install libncurses5-dev \
  libz-dev lib32gcc1 libc6-dev-i386 libssl-dev libglib2.0-dev libelf-dev 

RUN apt-get update && apt-get -y install patch device-tree-compiler antlr3 gperf qemu-utils

RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get -y install xmlto && unset DEBIAN_FRONTEND

RUN apt-get update && apt-get -y install asciidoc

# add user
RUN useradd -ms /bin/bash -U cooler

# config default env
USER cooler

WORKDIR /home/cooler

ADD src ./repos
