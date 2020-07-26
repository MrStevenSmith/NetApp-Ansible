#!/usr/bin/env bash

https://github.com/MrStevenSmith/NetApp-Ansible/tree/master/1.%20Installing%20Ansible%20and%20AWX/centos-8-ansible-install.sh
# Steven Smith

# Update OS and packages
yum update -y kernel
yum update -y

# Reboot
# init 6

# Install Dependancies
dnf makecache
dnf install epel-release -y
dnf install git gcc gcc-c++ nodejs gettext device-mapper-persistent-data lvm2 bzip2 python3-pip ansible -y
alternatives --set python /usr/bin/python3

# Open firewall ports
sed -i 's/SELINUX*/SELINUX=disabled/' /etc/sysconfig/selinux
firewall-cmd --zone=public --add-masquerade --permanent
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload

# Install docker-ce
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf install docker-ce-3:18.09.1-3.el7 -y
systemctl start docker
systemctl enable --now docker.service
usermod -aG docker $USER
# init 6

# Install Docker-Compose
pip3 install docker-compose

# Modify AWX Inverory File
cd ~
git clone https://github.com/ansible/awx.git
cd awx/installer/
sed -i 's/SELINUX*/SELINUX=disabled/' /etc/selinux/config
sed -i 's/postgres_data_dir*/postgres_data_dir=/var/lib/pgdocker/' /home/$USER/awx/installer/inventory
sed -i 's/awx_official*/awx_official=true' /home/$USER/awx/installer/inventory
sed -i 's/project_data_dir*/project_data_dir=/var/lib/awx/projects' /home/$USER/awx/installer/inventory
sed -i 's/awx_alternate_dns_servers*/' /home/$USER/awx/installer/inventory
sed -i 's/awx_alternate_dns_servers*/awx_alternate_dns_servers="4.2.2.1,4.2.2.2"' /home/$USER/awx/installer/inventory
sed -i 's/pg_admin_password=*/pg_admin_password=postgrespass@123' /home/$USER/awx/installer/inventory
SCK=$(openssl rand -base64 30)
sed -i "s|secret_key|secret_key=${SCK}|" /home/$USER/awx/installer/inventory

#nano inventory
## localhost ansible_connection=local ansible_python_interpreter="/usr/bin/env python3"
## postgres_data_dir=/var/lib/pgdocker
## awx_official=true
## project_data_dir=/var/lib/awx/projects
## awx_alternate_dns_servers="4.2.2.1,4.2.2.2"
## pg_admin_password=postgrespass@123

## secret_key=<output of below>
## openssl rand -base64 30


ansible-playbook -i inventory install.yml


# Modify AWX for NetApp
docker exec -it awx_task pip3 install netapp-lib requests solidfire-sdk-python
docker exec -it awx_task yum remove ansible -y
docker exec -it awx_task pip3 install ansible
docker exec -it awx_task ln -s /usr/local/bin/ansible /usr/bin/ansible
docker exec -it awx_task ln -s /usr/local/bin/ansible-galaxy /usr/bin/ansible-galaxy
docker exec -it awx_task ln -s /usr/local/bin/ansible-doc /usr/bin/ansible-doc
docker exec -it awx_task ansible-galaxy collection install netapp.ontap -p /usr/share/ansible/collections
docker exec -it awx_task ansible-galaxy collection install netapp.elementsw -p /usr/share/ansible/collections

# docker exec -it awx_task bash
# bash-4.4# pip3 install netapp-lib requests solidfire-sdk-python
# bash-4.4# yum remove ansible -y
# bash-4.4# pip3 install ansible
# bash-4.4# ln -s /usr/local/bin/ansible /usr/bin/ansible
# bash-4.4# ln -s /usr/local/bin/ansible-galaxy /usr/bin/ansible-galaxy
# bash-4.4# ln -s /usr/local/bin/ansible-doc /usr/bin/ansible-doc
# bash-4.4# ansible-galaxy collection install netapp.ontap -p /usr/share/ansible/collections
# bash-4.4# ansible-galaxy collection install netapp.elementsw -p /usr/share/ansible/collections
## You can also install any additional collections you want to use at this point using the appropriate namespace and collection you want (i.e., netapp.aws, cisco.ios, etc).
## *When Ansible or the Collections need to be updated repeat the ‘docker exec’ command and the last three lines of the above commands to upgrade.
# bash-4.4# exit
