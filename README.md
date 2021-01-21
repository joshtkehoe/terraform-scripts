# terraform-scripts
Scripts to help out with Terraform.

## init-terraform-gitlab-local.sh
This script helps to init terraform locally with state files that are stored in GitLab CI/CD.

### Requires
GitLab Access Token with appropriate API permissions. If you don't already have an access token, create one in your GitLab Setting Page (under Access Tokens). Make sure you copy the value of the token.

### To Use
Copy the script and paste it into your terraform directory. Run it from a terminal.

To take full advantage of this script, set the following environment variables in your .bashrc (or wherever you set environment variables).
* export TOKEN="{Your GitLab Access Token}"
* export TF_USERNAME="{Your GitLab username"
Note that we must export the env variables so that they will be available to the script. Also note that the username can be anything - it doesn't matter what you put - but whatever you use, it will show up in the GitLab Terraform State File GUI as the person that last modified it.
