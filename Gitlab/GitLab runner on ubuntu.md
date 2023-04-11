# How to install GitLab runner on ubuntu server:-

## Prerequisite:-
1. check the os version (lsb_release -a)
2. ssh into the server
## Install GitLab runner
1. Go to official docs (https://docs.gitlab.com/runner/install/linux-repository.html)
2. Then check whether you want to install using shell executor or docker executor
3. If shell executor then the prerequisite is none
4. To install GitLab Runner. Add the official GitLab repository:
```
curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
```
5. Install the GitLab Runner package:
```
sudo apt-get install gitlab-runner --working-directory value, --user value, -u value
```
6. Now check the user of the GitLab runner
```
ps aux | grep Gitlab-runner
```

## Register the GitLab-runner:-
1. run the following command to register the runner
 ```
sudo gitlab-runner register
```
2. Now go to Settings > CI/CD and expand the Runners section
3. There we can get the token and URL
4. now paste the token and URL in the terminal and press enter
