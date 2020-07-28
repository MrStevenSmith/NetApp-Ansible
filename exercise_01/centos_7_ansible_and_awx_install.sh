#!/usr/bin/env bash

# https://github.com/MrStevenSmith/NetApp-Ansible/tree/master/exercise_01/centos_7_ansible_and_awx_install.sh
# Steven Smith

# Update OS and packages
yum update -y kernel
yum update -y

# Install Dependancies
yum makecache
yum install epel-release -y
yum install nano git gcc gcc-c++ yum-utils nodejs gettext libselinux-python libselinux-python3 python3 device-mapper-persistent-data lvm2 bzip2 python3-pip ansible -y
alternatives --set python /usr/bin/python3
pip3 install netapp-lib solidfire-sdk-python requests
ansible-galaxy collection install netapp.ontap netapp.elementsw -p /usr/share/ansible/collections
chmod +rx /usr/share/ansible/collections

# Open firewall ports
sed -i '/^SELINUX=/c\SELINUX=disabled' /etc/sysconfig/selinux
firewall-cmd --zone=public --add-masquerade --permanent
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload

# Install docker-ce
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce-18.09.1 docker-ce-cli-18.09.1 containerd.io -y
systemctl start docker
systemctl enable --now docker.service
usermod -aG docker $USER

# Install Docker-Compose
pip3 install docker-compose

# Modify AWX Inverory File
cd ~
git clone https://github.com/ansible/awx.git
cd awx/installer/
sed -i '/^postgres_data_dir=/c\postgres_data_dir=/var/lib/pgdocker/' ~/awx/installer/inventory
sed -i '/project_data_dir=/s/^#//g' ~/awx/installer/inventory
sed -i '/^docker_compose_dir=/c\docker_compose_dir=/var/lib/awx/awxcompose/' ~/awx/installer/inventory
sed -i '/^project_data_dir=/c\project_data_dir=/var/lib/awx/projects' ~/awx/installer/inventory
sed -i '/awx_alternate_dns_servers=/s/^#//g' ~/awx/installer/inventory
sed -i '/^awx_alternate_dns_servers=/c\awx_alternate_dns_servers="4.2.2.1,4.2.2.2"' ~/awx/installer/inventory
sed -i '/^pg_password=/c\pg_password=postgrespass@123' ~/awx/installer/inventory
SCK=$(openssl rand -base64 30)
sed -i "/^secret_key=/c\secret_key=${SCK}" ~/awx/installer/inventory

# Install AWX
ansible-playbook -i inventory install.yml

# Modify AWX for NetApp
sleep 2m
docker exec -it awx_task pip3 install netapp-lib requests solidfire-sdk-python
docker exec -it awx_task yum remove ansible -y
docker exec -it awx_task pip3 install ansible
docker exec -it awx_task ln -s /usr/local/bin/ansible /usr/bin/ansible
docker exec -it awx_task ln -s /usr/local/bin/ansible-galaxy /usr/bin/ansible-galaxy
docker exec -it awx_task ln -s /usr/local/bin/ansible-doc /usr/bin/ansible-doc
docker exec -it awx_task ansible-galaxy collection install netapp.ontap -p /usr/share/ansible/collections
docker exec -it awx_task ansible-galaxy collection install netapp.elementsw -p /usr/share/ansible/collections
