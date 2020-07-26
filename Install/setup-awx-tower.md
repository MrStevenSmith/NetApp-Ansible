

1. Add Credential Type

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

2. Add Credential

Name: Cluster Admin
Description: ONTAP Cluster Admin
Credential Type: ONTAP
Username: admin
Password: Netapp1!

3. Project

Name: NetApp Workflow
SCM Type: Git
SCM URL: https://github.com/MrStevenSmith/NetApp-Ansible
SCM Update Options: Update Revision on Launch
Cache Timeout: 1800

4. Job Template

Name: volume_create  ## lowercase and 1 word for rest calls
Description: Volume Creation Module
Job Type: Run
Inventory: Demo Inventory
Project: NetApp WorkFlow
Playbook: create_volume.yml

