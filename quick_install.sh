#!/bin/bash
# This script is supposed to help Ubuntu users
# quickly install all the common/necessary programs after OS Installation
#
# Compatible for Ubuntu 18.04.2

SETUP_DIR="/home/$USER/Downloads/setup"

# Update the repositories
echo '(1) Running sudo apt update...'
sudo apt update

# necessary for downloading packages
echo '(2) Installing wget and curl...'
sudo apt install -y wget curl

# make a folder to store all the installation deb files
mkdir $SETUP_DIR

echo '(3) Downloading Google Chrome...'
# download the latest stable Google Chrome in
wget -P $SETUP_DIR https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# install Google Chrome
echo 'Installing Google Chrome'
sudo dpkg -i $SETUP_DIR/google-chrome-stable_current_amd64.deb
echo 'Google Chrome Installed!'

# install VSCode
echo 'Installing VSCode...'
sudo snap install --classic code
echo 'VSCode Installed!'

#install Spotify
echo 'Installing Spotify...'
sudo snap install --classic spotify
echo 'Spotify Installed!'

# install Chinese Language support
echo 'Installing Chinese Language keyboard...'
SCHEMA="org.gnome.desktop.input-sources"
KEY="sources"
sudo apt-get -y install ibus-libpinyin
gsettings set $SCHEMA $KEY "$(gsettings get $SCHEMA $KEY | sed "s/]/, ('ibus', 'libpinyin')]/")"
echo 'Chinese Language keyboard set up!'

# install Telegram Desktop
echo 'Installing Telegram Desktop...'
sudo snap install telegram-desktop
echo 'Telegram Desktop installed!'

# install Grub Customizer
# (to configure the Grub boot menu easily)
echo 'Installing Grub Customizer...'
sudo add-apt-repository ppa:danielrichter2007/grub-customizer
sudo apt-get update
sudo apt-get -y install grub-customizer
echo 'Grub Customizer Installed!'

# install Android Studio
echo 'Installing Android Studio...'
sudo snap install --classic android-studio
sudo apt-get -y install android-tools-adb android-tools-fastboot
sudo apt install -y qemu-kvm
sudo adduser $USER kvm
sudo chown $USER /dev/kvm
echo 'Android Studio installed!'

# install Tweaks tool
echo 'Installing Tweaks...'
sudo apt install gnome-tweak-tool libqt5svg5 qml-module-qtquick-controls -y
OCS_URL_LINK = https://www.pling.com/p/1136805/startdownload?file_id=1530774600&file_name=ocs-url_3.1.0-0ubuntu1_amd64.deb&file_type=application/x-debian-package&file_size=54502
wget -P $SETUP_DIR $OCS_URL_LINK
sudo dpkg -i $SETUP_DIR/$OCS_URL_LINK
echo 'Tweaks installed!'

# install Docker
echo 'Installing Docker...'
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose
echo 'Docker installed!'
sudo usermod -aG docker $USER
echo "$USER added to Docker group!"

# install nvm
echo 'Installing nvm...'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
exec bash
nvm install node
echo 'npm installed!'

# install yarn
echo 'Installing yarn...'
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install --no-install-recommends yarn
echo 'yarn installed!'

# upgrade existing packages
sudo apt upgrade

echo '
################### \n
################### \n
SET UP COMPLETE!
PLEASE REBOOT TO ENSURE THE CHANGES TAKE EFFECT
################### \n
################### \n
'

exit 0

