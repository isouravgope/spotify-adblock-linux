#!/usr/bin/bash

echo -e "starting the process"
blue=$(tput setaf 6)
cd ~

wget http://repository.spotify.com/pool/non-free/s/spotify-client/spotify-client_1.2.8.923.g4f94bf0d_amd64.deb

debfile=`find /home -iname "*spotify-client_1*amd64.deb"`
echo ${blue}"found spotify deb file on" $debfile ${txtrst}
sudo dpkg -i $debfile && sudo apt-get install -f 
sudo dpkg --configure -a
sudo apt --fix-broken install

sleep 2s
cd ~/Downloads
echo -e "installing the necessary package"

sudo apt-get install git gcc wget curl libcurl4-gnutls-dev rustc cargo
git clone https://github.com/abba23/spotify-adblock.git -b main spotifyadblockextra
spotifyextra=`find /home -iname "*spotifyadblock*"`
cd $spotifyextra


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
