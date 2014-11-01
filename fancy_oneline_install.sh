curl -sSL https://get.docker.com/ | sh
docker pull ezmac/docker-chrome-pulseaudio
echo "load-module module-native-protocol-tcp">>~/.config/pulse/default.pa
sudo service pulseaudio restart

docker run -ti --rm \
       -e DISPLAY=$DISPLAY \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v /home/$USER/.pulse-cookie:/home/chrome/.pulse-cookie:rw\
       google-chrome --no-sandbox
