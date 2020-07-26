# Setting up Ansible AWX for use

## Initial AWX Setup

### 1. Add Credential Type

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

### 2. Add Credential

```
Name: Cluster Admin
Description: ONTAP Cluster Admin
Credential Type: ONTAP
Username: admin
Password: Netapp1!
```

### 3. Project

```
Name: NetApp Workflow
SCM Type: Git
SCM URL: https://github.com/MrStevenSmith/NetApp-Ansible
SCM Update Options: Update Revision on Launch
Cache Timeout: 1800
```

### 4. Job Template

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

### 5. Add Survey

```
Prompt 1: What Aggregate should this Volume go on?
Answer Variable Name 1: aggrname
Answer Type 1: String
Required 1: Text
```

Add

Save