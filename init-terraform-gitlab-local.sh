#!/bin/bash

echo "Prod (p) or Test (t)?"
read TF_ENV

PROJ_NAME="{ENTER YOUR PROJECT NAME HERE"
PROJECT_ID="{ENTER YOUR GITLAB PROJECT ID HERE"
STATE_FILE_NAME="$PROJ_NAME-test"
if [ $TF_ENV == "p" ] || [ $TF_ENV == "P" ]; then
  STATE_FILE_NAME="$PROJ_NAME-prod"
elif [ $TF_ENV == "t" ] || [ $TF_ENV == "T" ]; then
  STATE_FILE_NAME="$PROJ_NAME-test"
else
  echo Unknown input
  exit
fi

if [[ -z "${TF_USERNAME}" ]]; then
  echo Enter your Gitlab username
  read TF_USERNAME
else
  echo "TF_USERNAME env variable is set to $TF_USERNAME"
fi

if [[ -z "${TOKEN}" ]]; then
  echo -n Enter your Gitlab API Key
  read -s TF_PASSWORD
else
  echo "TOKEN env variable set. Using that for TF Password"
  TF_PASSWORD=$TOKEN
fi

TF_ADDRESS="https://gitlab.com/api/v4/projects/$PROJECT_ID/terraform/state/$STATE_FILE_NAME"

printf "\n....\n"
printf "Connecting Terraform to $TF_ADDRESS. Stand by."

terraform init \
  -backend-config=address=${TF_ADDRESS} \
  -backend-config=lock_address=${TF_ADDRESS}/lock \
  -backend-config=unlock_address=${TF_ADDRESS}/lock \
  -backend-config=username=${TF_USERNAME} \
  -backend-config=password=${TF_PASSWORD} \
  -backend-config=lock_method=POST \
  -backend-config=unlock_method=DELETE \
  -backend-config=retry_wait_min=5

printf "Terraform init to $STATE_FILE_NAME\n"
