#!/bin/sh

# Setup ubuntu sytems
sudo apt-get install aptitude git ack-grep vim tmux firefox chromium-browser

# Spotify:
echo '# Spotify:' >> /etc/apt/sources.list
echo 'deb http://repository.spotify.com stable non-free' >> /etc/apt/sources.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59;
sudo apt-get update;
sudo apt-get install spotify-client;
