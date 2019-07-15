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
wget -P $SETUP_DIR/https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# install Google Chrome
echo '(4) Installing Google Chrome'
sudo dpkg -i $SETUP_DIR/google-chrome-stable_current_amd64.deb
echo '(5) Google Chrome Installed!'

# install VSCode
echo '(6) Installing VSCode...'
sudo snap install --classic code
echo '(7) VSCode Installed!'

# install Chinese Language support
echo '(8) Installing Chinese Language keyboard...'
SCHEMA="org.gnome.desktop.input-sources"
KEY="sources"
sudo apt-get -y install ibus-libpinyin
gsettings set $SCHEMA $KEY "$(gsettings get $SCHEMA $KEY | sed "s/]/, ('ibus', 'libpinyin')]/")"
echo '(9) Chinese Language keyboard set up!'

# install Telegram Desktop
echo '(9) Installing Telegram Desktop...'
sudo snap install telegram-desktop
echo '(10) Telegram Desktop installed!'

# install Grub Customizer
# (to configure the Grub boot menu easily)
echo '(11) Installing Grub Customizer...'
sudo add-apt-repository ppa:danielrichter2007/grub-customizer
sudo apt-get update
sudo apt-get -y install grub-customizer
echo '(12) Grub Customizer Installed!'

# install Android Studio
echo '(13) Installing Android Studio...'
sudo snap install --classic android-studio
sudo apt-get -y install android-tools-adb android-tools-fastboot
sudo apt install -y qemu-kvm
sudo adduser $USER kvm
sudo chown $USER /dev/kvm
echo '(14) Android Studio installed!'

# install Tweaks tool
echo '(15) Installing Tweaks...'
sudo apt install gnome-tweak-tool
echo '(16) Tweaks installed!'

# install Docker
echo '(16) Installing Docker...'
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
echo '(17) Docker installed!'
sudo usermod -aG docker $USER
echo "(18) $USER added to Docker group!"

# install nvm
echo '(19) Installing nvm...'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
exec bash
nvm install node
echo '(20) npm installed!'

# install yarn
echo '(21) Installing yarn...'
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install --no-install-recommends yarn
echo '(22) yarn installed!'

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
