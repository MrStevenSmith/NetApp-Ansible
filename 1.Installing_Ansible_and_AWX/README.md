# Exercise 1 - Install Ansible and AWX

## Exercise Overview



### Exercise Requirements

During this exercise we will use a NetApp LabOnDemand to provide our linux VM's and our ONTAP system.

To carry out this exercise you will need access to some Linux VM's.  You will also need access to a NetApp ONTAP based storage system.

For NetApp employees and partners who have access to [NetApp LabOnDemand](https://labondemand.netapp.com/) this exercise can be carried out using the [Using Trident with Kubernetes and ONTAP v3.1](https://labondemand.netapp.com/lab/sl10556) lab.








```
login as: root
root@rhel6.demo.netapp.com's password:
Last login: Fri Sep 27 15:49:16 2019 from jumphost.demo.netapp.com
[root@rhel6 ~]#
```



```
[root@rhel6 ~]# git clone https://github.com/MrStevenSmith/NetApp-Ansible.git
Cloning into 'NetApp-Ansible'...
remote: Enumerating objects: 225, done.
remote: Counting objects: 100% (225/225), done.
remote: Compressing objects: 100% (155/155), done.
remote: Total 225 (delta 99), reused 182 (delta 56), pack-reused 0
Receiving objects: 100% (225/225), 1.26 MiB | 0 bytes/s, done.
Resolving deltas: 100% (99/99), done.
[root@rhel6 ~]#
```



```
[root@rhel6 ~]# cd NetApp-Ansible/
[root@rhel6 NetApp-Ansible]# cd 1.Installing_Ansible_and_AWX/
[root@rhel6 1.Installing_Ansible_and_AWX]# chmod +x lod_sl10556_ansible_and_awx_install.sh
[root@rhel6 1.Installing_Ansible_and_AWX]#
```



```
[root@rhel6 1.Installing_Ansible_and_AWX]# ./lod_sl10556_ansible_and_awx_install.sh
Loaded plugins: langpacks, product-id, search-disabled-repos, subscription-manager
This system is not registered with an entitlement server. You can use subscription-manager to register.
RHEL_7.5_x86_64                                                                                    | 2.9 kB  00:00:00
docker-ce-stable                                                                                   | 3.5 kB  00:00:00
epel/x86_64/metalink                                                                               |  17 kB  00:00:00
epel                                                                                               | 4.7 kB  00:00:00
```

```
```
