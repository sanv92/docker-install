sudo su

# 1) Update
sudo apt-get update
echo "1) Update: Done!";
echo "";
echo "";

# 2) CA certificate install
sudo apt-get -y install apt-transport-https ca-certificates
echo "2) CA certificate install Done!";
echo "";
echo "";

# 3) Add new GPG key
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "3) GPG key add: Done!";
echo "";
echo "";

# 4) Remove file if exist
sudo rm -R /etc/apt/sources.list.d/docker.list
echo "4) Remove docker.list: Done!";
echo "";
echo "";

# 5) Create file
sudo touch /etc/apt/sources.list.d/docker.list
echo "5) Create docker.list: Done!";
echo "";
echo "";

# 6) File write
FILE="/etc/apt/sources.list.d/docker.list"
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee $FILE
echo "6) Add repo docker.list: Done!";
echo "";
echo "";

# 7) Update
sudo apt-get update
echo "7) Update: Done!";
echo "";
echo "";

# 8) Install Docker
sudo apt-get -y install docker-engine
echo "8) Install Docker: Done!";
echo "";
echo "";

# 9) add user & password
#sudo useradd udocker
#sudo passwd udocker
#echo udocker | passwd udocker --stdin

# 9) Dockre group
sudo groupadd docker
if [ $USER == "vagrant" ]
then
    sudo usermod -aG docker vagrant
else
    sudo usermod -aG docker $USER
fi
echo "9) Dockre group: Done!";
echo "";
echo "";

# 10) Create folder
sudo mkdir /var/srv
if [ $USER == "vagrant" ]
then
    sudo chown -R vagrant:docker /var/srv
else
    sudo chown -R $USER:docker /var/srv
fi
echo "10) Create folder && USER chown: Done!";
echo "";
echo "";

# 11)
# old # GRUB_CMDLINE_LINUX=""
# new # GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"
sudo sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"/g' /etc/default/grub
echo "11) Adjust memory and swap accounting: Done!";
echo "";
echo "";

# 13)
# Adjust memory and swap accounting
#FIND_GRUB=$(grep "cgroup_enable=memory swapaccount=1" /etc/default/grub)
#LENGTH_GRUB=$(echo -n "$FIND_GRUB" | wc -c);

# if else
#if [ FIND_GRUB > 3 ]
#then
#    echo "GRUB_CMDLINE_LINUX -> exist!";
#else
#    echo GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1" >> /etc/default/grub
#    sudo update-grub
#fi

# 12)
# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.8.1/docker-compose-$(uname -s)-$(uname -m)" > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version
echo "12) Install Docker Compose: Done!";
echo "";
echo "";





sudo update-grub
sudo service docker restart
echo "All Done!";
echo "";
echo "";


