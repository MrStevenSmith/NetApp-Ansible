

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

