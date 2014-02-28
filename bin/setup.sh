#!/bin/sh

# Setup ubuntu sytems
sudo apt-get install aptitude git ack-grep vim tmux firefox chromium-browser virtualbox keepass2 ssh curl g++

# Spotify:
sudo add-apt-repository "deb http://repository.spotify.com stable non-free"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59;
sudo apt-get update;
sudo apt-get install spotify-client;

# Chrome:
# sudo add-apt-repository "deb http://dl.google.com/linux/deb/ stable non-free"
# sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# sudo apt-get update
# sudo apt-get install google-chrome-stable

# Skype:
sudo dpkg --add-architecture i386
sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
sudo apt-get update && sudo apt-get install skype
