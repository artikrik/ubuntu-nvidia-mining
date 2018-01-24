#!bin/bash
echo '##### Installing updates and install soft...'
sudo apt-get install -y git && sudo apt-get install -y openssh-server && sudo apt-get install -y screen && sudo apt-get install -y htop
echo '#### Xorg server disabling for the next sessions... (to enable use command [systemctl set-default graphical.target])'
sleep 5
sudo systemctl set-default multi-user.target
echo '#### Xorg server disabling for the next sessions... (to enable use command [systemctl set-default graphical.target])'
sleep 5
sudo killall /usr/bin/X
sudo service lightdm stop
echo 'Please make sure the system sees all GPUs...'
sleep 5
printf "$(lspci -v | grep VGA)\n"
