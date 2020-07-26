# Setting up Ansible AWX for use

## Initial AWX Setup

During the first exercise we installed Ansible and AWX Tower.  If you have not yet completed this task please follow [Exercise 1](https://github.com/MrStevenSmith/NetApp-Ansible/tree/master/1.Installing_Ansible_and_AWX)

In this exercise we will configure Ansible AWX for basic use and run a simple playbook to create a new volume.

### 1. Add a new Credential Type

Firstly we need to create a Credential type to store our ONTAP credentials.  A credential type defines what variables we are going to use when creating our credentials, which in this case is the ONTAP username and password.

To do this click on the left hand link 'Credential Types' and click the green plus sign.

<img align="center" src="https://github.com/MrStevenSmith/NetApp-Ansible/blob/master/2.Setting_up_Ansible_AWX/images/credential_type_01.png">

We must now create our new credential type.  Fill in the fields listed below.

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

Once complete click on 'Save' and you should now see your new credential type.

<img align="center" src="https://github.com/MrStevenSmith/NetApp-Ansible/blob/master/2.Setting_up_Ansible_AWX/images/credential_type_03.png">

### 2. Add a new Credential

Now that we have created our Credential type we can add our credential.  For this exercise we are just going to add the cluster admin account, however in production we would normally create a service account and use that for authentication on the ONTAP system.

Click the link 'Credentials' on the left and click the green plus sign.

<img align="center" src="https://github.com/MrStevenSmith/NetApp-Ansible/blob/master/2.Setting_up_Ansible_AWX/images/credential_01.png">

For our new credential fill out the fields listed below.

```
Name: Cluster Admin
Description: ONTAP Cluster Admin
Credential Type: ONTAP
Username: admin
Password: Netapp1!
```

* Note: the details above are correct for the ONTAP cluster in the LabOnDemand.  If you are using a different system then you will need to change the details above as appropriate.

<img align="center" src="https://github.com/MrStevenSmith/NetApp-Ansible/blob/master/2.Setting_up_Ansible_AWX/images/credential_02.png">

Once complete click on 'Save' and you should now see your new credential.

<img align="center" src="https://github.com/MrStevenSmith/NetApp-Ansible/blob/master/2.Setting_up_Ansible_AWX/images/credential_03.png">

### 3. Create a new Project

We will now create a new Project.  Our project will define the location of the source files.  As we are using git for source control we will point our project at this github repository.

We will configure our project to update our source files at launch to ensure we are using the latest version.  However we do not want to do this at every run so we will put a cache timeout of 30 minutes before a new update is carried out.

To create our new project click on 'Projects' on the left hand side and click the green plus sign.

<img align="center" src="https://github.com/MrStevenSmith/NetApp-Ansible/blob/master/2.Setting_up_Ansible_AWX/images/project_01.png">

Fill out the below fields to configure our Project.

```
Name: NetApp Workflow
SCM Type: Git
SCM URL: https://github.com/MrStevenSmith/NetApp-Ansible
SCM Update Options: Update Revision on Launch
Cache Timeout: 1800
```

<img align="center" src="https://github.com/MrStevenSmith/NetApp-Ansible/blob/master/2.Setting_up_Ansible_AWX/images/project_02.png">

Once complete click on 'Save' and you should now see your new project.

<img align="center" src="https://github.com/MrStevenSmith/NetApp-Ansible/blob/master/2.Setting_up_Ansible_AWX/images/project_03.png">

When the button on the right of the project is green this shows that the source code has been downloaded.  If you wish to manually refresh the source code you can click on the cycle button to the right of the project.

### 4. Job Template

Now that we have 

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
