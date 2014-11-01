FROM ubuntu:latest
MAINTAINER Tad Merchant <system.root@gmail.com>

# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Make sure the repository information is up to date
RUN apt-get update

# Install Chrome
ADD sources.list /etc/apt/
RUN apt-get -y update
RUN apt-get install -y -q python-software-properties software-properties-common wget
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
RUN sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get -y update
RUN apt-get install -y google-chrome-stable pepperflashplugin-nonfree

# Install Pulseaudio
RUN apt-get install -y pulseaudio 
ADD asoundrc /home/chrome/.asoundrc


# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
  mkdir -p /home/chrome && \
  echo "chrome:x:${uid}:${gid}:chrome,,,:/home/chrome:/bin/bash" >> /etc/passwd && \
  echo "chrome:x:${uid}:" >> /etc/group && \
  echo "chrome ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/chrome && \
  chmod 0441 /etc/sudoers.d/chrome && \
  chown ${uid}:${gid} -R /home/chrome &&\
  adduser chrome audio

RUN chown -R chrome:chrome /home/chrome/

RUN echo "load-module module-native-protocol-tcp">>/etc/pulse/default.pa

USER chrome
ENV HOME /home/chrome
ENV PULSE_SERVER 172.17.42.1
ENTRYPOINT ["/usr/bin/google-chrome"]
#http://grooveshark.com/#!/writhewrithemm/broadcast
