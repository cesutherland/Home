#!/bin/sh

# Setup ubuntu sytems
sudo apt-get install aptitude git ack-grep vim tmux firefox chromium-browser virtualbox keepass2 ssh curl g++ redshift libnotify-bin sqlite postgresql

# Spotify:
sudo add-apt-repository "deb http://repository.spotify.com stable non-free"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59;
sudo apt-get update;
sudo apt-get install spotify-client;
