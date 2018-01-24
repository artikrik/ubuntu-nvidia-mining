#! /bin/bash
if [ "$(whoami)" != "root" ]; then
	echo -e "\033[0;31mSorry, you are not root. Please use sudo option\033[0m"
	exit 1
fi
echo -e '\033[0;32m##### Installing updates and install soft...\033[0m'
apt-get install -y git && apt-get install -y screen htop mc && apt-get clean -y && apt-get autoremove -y && sudo apt update -y && sudo apt upgrade -y
echo -e '\033[0;32m##### Xorg server disabling...\033[0m'
sleep 2
#systemctl set-default multi-user.target
service lightdm stop
#killall /usr/bin/X
echo -e '\033[0;32m##### Please make sure the system sees all GPUs... if it doesnt something is wrong with the build. Update the repository database and install any updates: sudo apt update && sudo apt upgrade... then restart\033[0m'
printf "\033[0;32m VGA CARD \033[0m $(lspci -v | grep VGA)\n"
sleep 20
echo -e '\033[0;32mInstalling NVIDIA repo and drivers [v384]... and enable Xorg\033[0m'
sudo apt-get purge nvidia-* -y && apt-get autoremove -y &&add-apt-repository ppa:graphics-drivers/ppa -y && sudo apt-get install nvidia-384 -y
#sudo apt-get --purge remove xserver-xorg-video-nouveau
#systemctl set-default multi-user.target
#killall /usr/bin/X
#service lightdm stop
service lightdm start
sleep 90
echo -e '\033[0;32m#### Select the Nvidia GPUs and enable them all for over-clocking\033[0m'
sleep 2
prime-select nvidia
nvidia-xconfig --enable-all-gpus
echo -e '\033[0;32m#### Make a copy of the default Xorg configuration file\033[0m'
sleep 2
mv /etc/X11/xorg.conf /etc/X11/xorg_bak.conf
echo -e '\033[0;32m#### Enable full over-clocking capabilities for your GPUs\033[0m'
sleep 2
nvidia-xconfig -a --cool-bits=31 --allow-empty-initial-configuration
echo -e '\033[0;32m#### populate the xorg.conf file with the required parameters for enabling over-clocking\033[0m'
sleep 2
sed -i '/Option "AllowEmptyInitialConfiguration" "True"/a Option "ConnectedMonitor" "DFP-0"' /etc/X11/xorg.conf
sed -i '/Option "ConnectedMonitor" "DFP-0"/a Option "CustomEDID" "DFP-0:/etc/X11/dfp0.edid"' /etc/X11/xorg.conf
cp dfp0.edid /etc/X11/dfp0.edid
chattr +i /etc/X11/xorg.conf
echo -e '\033[0;32m#### Everything is done! Will reboot after 1 minute...\033[0m'
sleep 60
shutdown -r now
exit 0
