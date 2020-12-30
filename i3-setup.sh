#!/bin/bash
# Configures an i3 system to my personal taste
# Created by Adrian David (December 2020)

# Prerequisites:
# Before running this, install i3-gaps:
#	`sudo apt install i3-gaps`

I3_DIR=~/.config/i3
POLYBAR_DIR=~/.config/polybar

# install fonts
mkdir -p ~/.fonts
cp -a ./fonts/. ~/.fonts
fc-cache -fv

# install adapta theme
apt-add-repository ppa:tista/adapta
apt-get install adapta-gtk-theme

GTK3_CONFIG=~/.config/gtk-3.0/settings.ini
# configure gtk (replacing key value pairs in config file)
# note that there may be more versions of GTK installed 
./replaceSetting GTK3_CONFIG gtk-theme-name Adapta-LightBlue-Adapta-LightBlue-Nokto-Eta
./replaceSetting GTK3_CONFIG gtk-font-name "Liberation Sans 11"
./replaceSetting GTK3_CONFIG gtk-xft-antialias 1
./replaceSetting GTK3_CONFIG gtk-xft-hinting 1
./replaceSetting GTK3_CONFIG gtk-xft-hintstyle hintfull

# copy script for moving containers to previous and next workspaces
cp ./i3MoveNext.sh $I3_DIR
chmod +x ~/.config/i3/i3MoveNext.sh
apt install jq # script uses jq

# replace i3 config
mkdir -p $I3_DIR
cp -rT ./i3 $I3_DIR

# install polybar
apt install polybar

# installing player-mpris-tail dependencies (polybar media module)
python3 -m pip install dbus-python
apt install python-gobject

# replace the existing default polybar config
cp -rT ./polybar $POLYBAR_DIR

# install compton
apt install compton

# add compton config
cp ./compton.conf ~/.config

# install betterlockscreen and dependencies
sudo apt install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev

chmod +x ./i3lock-color-master/build.sh
./i3lock-color-master/build.sh

chmod +x ./i3lock-color-master/install-i3lock-color.sh
./i3lock-color-master/install-i3lock-color.sh

sudo apt install imagemagick

chmod u+x ~/.config/i3/betterlockscreen

# install and configure rofi
sudo apt install rofi
mkdir -p ~/.config/rofi
cp -r ./rofi ~/.config/rofi

# install cava and dependencies
apt-get install libfftw3-dev libasound2-dev libncursesw5-dev libpulse-dev libtool automake libiniparser-dev
export CPPFLAGS=-I/usr/include/iniparser

./cava/autogen.sh
./cava/configure
(cd ./cava && make install)

cp ./cava.config ~/.config/cava/config

# add flows scripts to .profile (for rofi to detect)
echo '# adding i3 flow scripts' >> ~/.profile
echo 'if [ -d "$HOME/.config/i3/flows" ]; then' >> ~/.profile
echo '    PATH="$HOME/.config/i3/flows:$PATH"' >> ~/.profile
echo 'fi'
