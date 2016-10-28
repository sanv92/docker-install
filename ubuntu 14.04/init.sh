sudo su

# 1) Update
sudo apt-get update

# 2) CA certificate install
sudo apt-get -y install apt-transport-https ca-certificates

# 3) Add new GPG key
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# 4) Remove file if exist
sudo rm -R /etc/apt/sources.list.d/docker.list

# 5) Create file
sudo touch /etc/apt/sources.list.d/docker.list

# 6) File write
FILE="/etc/apt/sources.list.d/docker.list"
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee $FILE

# 7) Update
sudo apt-get update

# 8) Install Docker
sudo apt-get -y install docker-engine

# 9) add user & password
sudo useradd udocker
sudo passwd udocker
#echo udocker | passwd udocker --stdin

# 10) Dockre group
sudo groupadd docker
USER="udocker"
sudo usermod -aG docker $USER

# 11) Create folder
sudo mkdir /var/www
sudo chown -R udocker:docker /var/www
sudo chown -R udocker:docker /vagrant

# 12)
# old # GRUB_CMDLINE_LINUX=""
# new # GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"
sudo sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"/g' /etc/default/grub
sudo update-grub

sudo service docker restart

# 13)
# Adjust memory and swap accounting
FIND_GRUB=$(grep "cgroup_enable=memory swapaccount=1" /etc/default/grub)
LENGTH_GRUB=$(echo -n "$FIND_GRUB" | wc -c);

# if else
if [ FIND_GRUB > 3 ]
then
    echo "GRUB_CMDLINE_LINUX -> exist!";
else
    echo GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1" >> /etc/default/grub
fi
