#! /bin/bash
echo -e '\033[0;32m##### Installing updates and install soft...\033[0;32m'
sudo apt-get install -y git && sudo apt-get install -y openssh-server && sudo apt-get install -y screen && sudo apt-get install -y htop
echo -e '\033[0;32m##### Xorg server disabling for the next sessions... (to enable use command [systemctl set-default graphical.target])\033[0;32m'
sleep 5
sudo systemctl set-default multi-user.target
sleep 5
sudo killall /usr/bin/X
sudo service lightdm stop
echo -e '\033[0;32m##### Please make sure the system sees all GPUs...\033[0;32m'
sleep 5
printf "\033[0;32m VGA CARD $(lspci -v | grep VGA)\n\033[0;32m"
