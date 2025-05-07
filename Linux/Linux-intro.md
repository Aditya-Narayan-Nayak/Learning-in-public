# What is Linux?

Linux is nothing but just an group of files and folders. It is a free and open source operating system.

## Linux OS and file System

![Screenshot (62)](https://user-images.githubusercontent.com/72183256/231080307-667fcae9-ff2d-4d25-b4d3-10273134d0c2.png)

### Linux commands

- ls:- list the files and folders in the current directory
- pwd:- print the current working directory
- cd:- change the current working directory
- clear:- clear the terminal screen
- grep 'string' file:- print the lines which contains the string in the file
- CTRL + R:- search the command history
- CTRL + L:- clear the terminal screen
  
## Scenario

1. print the linux distribution information
   - lsb_release -a:- print the linux distribution information
   - man:- print the manual of the command
   - man lsb_release:- print the manual of the lsb_release command
   - cat /etc/os-release:- print the linux distribution information
   - uname -a:- print the linux kernel information
   - lscpu:- print the cpu information
   - lsmem:- print the memory information

2. logs in Linux
   - IF we want to see the logs of the system either we can change the directory to /var/log or we can use find
   - man find:- we can use to find what this command does
   - find / -name 'syslog' :- find the file name syslog in the root directory
   - cd /var/log:- change the directory to /var/log
   - cat syslog | grep 'systemd' :- print the lines which contains systemd in the syslog file

3. Creating a user in Linux
   - useradd:- create a new user
   - useradd -D:- print the default useradd configuration
   - useradd -D -s /bin/bash:- change the default shell to bash
   - echo $0:- print the default shell
   - cat /etc/shells:- print the list of available shells
   - env | grep SHELL:- print the default shell
   - passwd user1:- set the password for the user1
   - usermod -aG sudo user1:- add the user1 to the sudo group
   - groupadd docker:- create a new group docker
   - getent group docker:- print the group inform