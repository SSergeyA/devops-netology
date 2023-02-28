#!/bin/bash
export TF_VAR_YC_TOKEN=$(yc iam create-token)
export TF_VAR_YC_CLOUD_ID=$(yc config get cloud-id)
export TF_VAR_YC_FOLDER_ID=$(yc config get folder-id)
read -p "Enter admin pass for db: " adminpass
export TF_VAR_adminpass=$adminpass