# Google chrome with pepper flash and pulseaudio

Docker for hipsters who run any modern linux and don't want to pollute their clean os with filthy "proprietary" software.'

runs official google-chrome and Pepper Flash. I made this to watch netflix in wheezy.  As far as I know, google-chrome doesn't work without glibc 2.15. Since I didn't want to add experimental, I just dockered it. 

uses pulseaudio network streaming and cookie for authentication

Install requires adding "load-module module-native-protocol-tcp" to /etc/pulse/default.pa and restarting pulse `sudo service pulseaudio restart`.  Assumes docker host (pulse host) is running on 172.17.42.1. Should be overridable with -e PULSE_SERVER=hostip.

Built on debian wheezy, docker version 1.3.1.

Please point out any errors or ways it could be improved.

## Install script

```bash
# if you dont have docker
curl -sSL https://get.docker.com/ | sh
#if you have docker

sudo su -c 'echo "load-module module-native-protocol-tcp">>/etc/pulse/default.pa'
sudo service pulseaudio restart

docker pull ezmac/google-chrome
docker run -ti --rm \
       -e DISPLAY=$DISPLAY\
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v /home/$USER/.pulse-cookie:/home/chrome/.pulse-cookie:rw\
       ezmac/google-chrome --no-sandbox
```

## thanks to / references

http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/
https://github.com/jlund/docker-chrome-pulseaudio
