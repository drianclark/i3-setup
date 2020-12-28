#!/bin/bash
# Configures an i3 system to my personal taste
# Created by Adrian David (December 2020)

# Prerequisites:
# Before running this, install i3-gaps:
#	`sudo apt install i3-gaps`

I3DIRECTORY=~/.config/i3

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

# load gnome-terminal transparent profile
dconf load /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ < transparent.dconf

# copy script for moving containers to previous and next workspaces
cp ./i3MoveNext.sh $I3DIRECTORY
chmod +x ~/.config/i3/i3MoveNext.sh
apt install jq # script uses jq

# copying the script for generating ordinal date
cp ./ordinalDate.sh $I3DIRECTORY

# install i3blocks
apt install i3blocks

# replace the existing default i3blocks config
cp /etc/i3blocks.conf $I3DIRECTORY

# copy the volume script to the i3 directory (i3blocks config calls it from there)
cp /usr/share/i3blocks/volume $I3DIRECTORY

# replace the existing default i3 config
cp ./config $I3DIRECTORY


