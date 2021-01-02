#!/bin/bash
# Configures an i3 system to my personal taste
# Created by Adrian David (December 2020)

# Prerequisites:
# Before running this, install i3-gaps:
#	`sudo apt install i3-gaps`

I3_DIR=~/.config/i3
POLYBAR_DIR=~/.config/polybar

# install script dependencies
apt install jq # i3MoveNext script uses jq
chmod +x ~/.config/i3/i3MoveNext.sh

# install fonts
mkdir -p ~/.fonts
cp -a ./fonts/. ~/.fonts
fc-cache -fv

# install adapta theme
apt-add-repository ppa:tista/adapta
apt-get install adapta-gtk-theme

GTK3_CONFIG=~/.config/gtk-3.0/settings.ini
chmod +x ./replaceSetting
# configure gtk (replacing key value pairs in config file)
# note that there may be more versions of GTK installed 
./replaceSetting GTK3_CONFIG gtk-theme-name Adapta-LightBlue-Adapta-LightBlue-Nokto-Eta
./replaceSetting GTK3_CONFIG gtk-font-name "Liberation Sans 11"
./replaceSetting GTK3_CONFIG gtk-xft-antialias 1
./replaceSetting GTK3_CONFIG gtk-xft-hinting 1
./replaceSetting GTK3_CONFIG gtk-xft-hintstyle hintfull

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

# install xautolock to autolock after some inactivity
sudo apt install xautolock

# install and configure rofi
sudo apt install rofi
mkdir -p ~/.config/rofi
cp -rT ./rofi ~/.config/rofi

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

# hide gnome-terminal menu bar by default
gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false
gsettings set org.gnome.Terminal.Legacy.Settings headerbar false

# set terminal font
PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
FONT='Roboto Mono Regular 10'
gsettings get "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/" cursor-shape 'ibeam'

gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/" font '"$FONT"'

# allowing execute for all automation scripts
chmod -R +x ~/.config/i3/flows