#!/bin/bash
# Configures an i3 system to my personal taste
# Created by Adrian David (December 2020)

# Prerequisites:
# Before running this, install i3-gaps:
#	`sudo apt install i3-gaps`

I3DIRECTORY=~/.config/i3
POLYBAR_DIR=~/.config/polybar

# install fonts
mkdir -p ~/.fonts
cp -a ./fonts/. ~/.fonts

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
cp -rT ./i3 $I3DIRECTORY

# install polybar
apt install polybar

# replace the existing default polybar config
cp -rT ./polybar $POLYBAR_DIR

# install compton
apt install compton
cp ./compton.conf ~/.config


