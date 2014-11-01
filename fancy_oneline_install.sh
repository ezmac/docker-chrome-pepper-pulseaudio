curl -sSL https://get.docker.com/ | sh
docker pull ezmac/docker-chrome-pulseaudio
echo "load-module module-native-protocol-tcp">>~/.config/pulse/default.pa
sudo service pulseaudio restart
docker pull ezmac/google-chrome

docker run -ti --rm \
       -e DISPLAY=$DISPLAY \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v /home/$USER/.pulse-cookie:/home/chrome/.pulse-cookie:rw\
       ezmac/google-chrome --no-sandbox
