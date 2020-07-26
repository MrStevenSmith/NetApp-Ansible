# Exercise 3 - Using Variables

## 

This exercise is dependant on the previous exercises.  If you have not yet completed these tasks please start with [Exercise 1](https://github.com/MrStevenSmith/NetApp-Ansible/tree/master/1.Installing_Ansible_and_AWX)

In this exercise we will .

### 1. 

### 5. Add Survey

We could hard code the aggregate name which we want the volume to be created on, however this makes the script very static.  We will instead use a variable to get the aggregate name.  To get this variable we need to create a survey.

To do this click on the 'Survey' button at the top of our job template.

<img align="center" src="https://github.com/MrStevenSmith/NetApp-Ansible/blob/master/2.Setting_up_Ansible_AWX/images/survey_01.png">

We are now going to add our question.  Fill out the fileds listed below.

```
Prompt 1: What Aggregate should this Volume go on?
Answer Variable Name 1: aggrname
Answer Type 1: String
Required 1: Text
```

Once done click 'Add'.

<img align="center" src="https://github.com/MrStevenSmith/NetApp-Ansible/blob/master/2.Setting_up_Ansible_AWX/images/survey_02.png">

The new survey question should be shown at the bottom in the preview section.  Once finished click 'Save'.

<img align="center" src="https://github.com/MrStevenSmith/NetApp-Ansible/blob/master/2.Setting_up_Ansible_AWX/images/survey_03.png">
