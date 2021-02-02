#!/usr/bin/bash

echo -e "starting the process"
sudo dpkg -i spotify-client_1.1.42.622.gbd112320-37_amd64.deb && sudo apt-get install -f 
sudo dpkg --configure -a

sleep 2s
cd ~/Downloads
echo -e "installing the necessary package"

sudo apt-get install git gcc wget curl
git clone https://github.com/abba23/spotify-adblock-linux.git -b master spotifyadblockextra
spotifyextra=`find /home -iname "*spotifyadblock*"`
cd $spotifyextra
echo -e "adding the cef chromium framework"
wget -O cef.tar.bz2 http://opensource.spotify.com/cefbuilds/cef_binary_80.0.8%2Bgf96cd1d%2Bchromium-80.0.3987.132_linux64_minimal.tar.bz2

sleep 2s && echo -e "decompressing the framework"
sleep 2s
tar -xvf cef.tar.bz2 --wildcards '*/include' --strip-components=1

make
echo -e "installing the elf binary"
sudo make install

sleep 2s 

echo -e "making a destop application for the installed lib"
cd ~/.local/share/applications

curl https://raw.githubusercontent.com/Project-Junk/spotify-adblock-linux-/main/spotifylinux.desktop > spotifylinux.desktop
echo -e "script ran successfully"
cd ~/
sleep 5s
zenity --info --text="if you want to change the name of the application change it in the desktop entry located in ~/.local/share/applications/spotifylinux.desktop :)"
exit
