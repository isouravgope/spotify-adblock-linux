#!/usr/bin/bash

echo -e "starting the process"
blue=$(tput setaf 6)
wget https://github.com/Project-Junk/spotify-adblock-linux-/blob/main/spotify-client-0.9.17_0.9.17.8.gd06432d.31-1_amd64.deb?raw=true --output-document=spotify-client-0.9.17_0.9.17.8.gd06432d.31-1_amd64.deb

debfile=`find /home -iname "*spotify-client-0.9.17_0.9.17.8.gd06432d.31-1_amd64.deb*"`
echo ${blue}"found spotify deb file on" $debfile ${txtrst}
sudo dpkg -i $debfile && sudo apt-get install -f 
sudo dpkg --configure -a

sleep 2s
cd ~/Downloads
echo -e "installing the necessary package"

sudo apt-get install git gcc wget curl libcurl4-gnutls-dev
git clone https://github.com/abba23/spotify-adblock-linux.git -b master spotifyadblockextra
spotifyextra=`find /home -iname "*spotifyadblock*"`
cd $spotifyextra
echo -e "adding the cef chromium framework"
wget -O cef.tar.bz2 https://cef-builds.spotifycdn.com/cef_binary_88.1.6%2Bg4fe33a1%2Bchromium-88.0.4324.96_linux64_minimal.tar.bz2wget -O cef.tar.bz2 https://cef-builds.spotifycdn.com/cef_binary_88.1.6%2Bg4fe33a1%2Bchromium-88.0.4324.96_linux64_minimal.tar.bz2

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
