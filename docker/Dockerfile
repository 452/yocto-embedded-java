FROM ubuntu:16.04

WORKDIR /root
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get autoremove -y --purge && \
    apt-get install gawk wget git diffstat unzip texinfo gcc-multilib \
    build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
    xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
    xterm vim tar locales -y

RUN rm /bin/sh && ln -s bash /bin/sh

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV USER_NAME yocto
ENV PROJECT yocto
ENV HOME /home/$USER_NAME

RUN groupadd -r $USER_NAME \
  && useradd -r -g $USER_NAME $USER_NAME
RUN mkdir -p /home/$USER_NAME/downloads \
  && chown -R $USER_NAME:$USER_NAME /home/$USER_NAME/downloads
VOLUME /home/$USER_NAME/downloads
USER $USER_NAME

WORKDIR $HOME
ENV GIT_BRANCH warrior
RUN git clone -b $GIT_BRANCH --depth=1 git://git.yoctoproject.org/poky && \
    git clone -b $GIT_BRANCH --depth=1 git://git.openembedded.org/meta-openembedded
RUN git clone -b $GIT_BRANCH --depth=1 git://git.yoctoproject.org/meta-raspberrypi
RUN git clone -b $GIT_BRANCH --depth=1 git://git.yoctoproject.org/meta-java
COPY build.sh $HOME/build.sh

CMD ["/bin/bash", "build.sh"]