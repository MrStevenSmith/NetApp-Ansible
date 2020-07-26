# Setting up Ansible AWX for use

## Initial AWX Setup

During the first exercise we installed Ansible and AWX Tower.  If you have not yet completed this task please follow [Exercise 1](https://github.com/MrStevenSmith/NetApp-Ansible/tree/master/1.Installing_Ansible_and_AWX)

In this exercise we will configure Ansible AWX for basic use and run a simple playbook to create a new volume.

### 1. Add Credential Type

Firstly we need to create a Credential type to store our ONTAP credentials.

To do this click on the left hand link 'Credential Type' and click the green plus sign.

<img align="center" src="https://github.com/MrStevenSmith/NetApp-Ansible/blob/master/2.Setting_up_Ansible_AWX/images/credential_type_01.png">

```
Name: ONTAP
Description: ONTAP Credential
Input Configuration:
  ---
  fields:
    - id: netapp_username
      type: string
      label: Username
    - id: netapp_password
      type: string
      label: Password
      secret: true
Injector Configuration:
  ---
  extra_vars:
    netapp_username: '{{ netapp_username }}'
    netapp_password: '{{ netapp_password }}'
```

<img align="center" src="https://github.com/MrStevenSmith/NetApp-Ansible/blob/master/2.Setting_up_Ansible_AWX/images/credential_type_02.png">

<img align="center" src="https://github.com/MrStevenSmith/NetApp-Ansible/blob/master/2.Setting_up_Ansible_AWX/images/credential_type_03.png">

### 2. Add Credential

<img align="center" src="https://github.com/MrStevenSmith/NetApp-Ansible/blob/master/2.Setting_up_Ansible_AWX/images/credential_01.png">

```
Name: Cluster Admin
Description: ONTAP Cluster Admin
Credential Type: ONTAP
Username: admin
Password: Netapp1!
```

<img align="center" src="https://github.com/MrStevenSmith/NetApp-Ansible/blob/master/2.Setting_up_Ansible_AWX/images/credential_02.png">

<img align="center" src="https://github.com/MrStevenSmith/NetApp-Ansible/blob/master/2.Setting_up_Ansible_AWX/images/credential_03.png">

### 3. Project

<img align="center" src="https://github.com/MrStevenSmith/NetApp-Ansible/blob/master/2.Setting_up_Ansible_AWX/images/project_01.png">

```
Name: NetApp Workflow
SCM Type: Git
SCM URL: https://github.com/MrStevenSmith/NetApp-Ansible
SCM Update Options: Update Revision on Launch
Cache Timeout: 1800
```

<img align="center" src="https://github.com/MrStevenSmith/NetApp-Ansible/blob/master/2.Setting_up_Ansible_AWX/images/project_02.png">

<img align="center" src="https://github.com/MrStevenSmith/NetApp-Ansible/blob/master/2.Setting_up_Ansible_AWX/images/project_03.png">

### 4. Job Template

<img align="center" src="https://github.com/MrStevenSmith/NetApp-Ansible/blob/master/2.Setting_up_Ansible_AWX/images/template_01.png">

```
Name: volume_create  ## lowercase and 1 word for rest calls
Description: Volume Creation Module
Job Type: Run
Inventory: Demo Inventory
Project: NetApp WorkFlow
Playbook: ansible-playbooks/create_volume.yml
Credentials: Cluster Admin (from ONTAP)
```

Save

<img align="center" src="https://github.com/MrStevenSmith/NetApp-Ansible/blob/master/2.Setting_up_Ansible_AWX/images/template_02.png">

### 5. Add Survey

<img align="center" src="https://github.com/MrStevenSmith/NetApp-Ansible/blob/master/2.Setting_up_Ansible_AWX/images/survey_01.png">

```
Prompt 1: What Aggregate should this Volume go on?
Answer Variable Name 1: aggrname
Answer Type 1: String
Required 1: Text
```

Add

Save

<img align="center" src="https://github.com/MrStevenSmith/NetApp-Ansible/blob/master/2.Setting_up_Ansible_AWX/images/survey_02.png">
