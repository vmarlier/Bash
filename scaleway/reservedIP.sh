#!/bin/bash

if ! command -v jq &> /dev/null
then
    echo "jq could not be found"
    exit
fi

read -p 'Enter the project ID: ' SCW_DEFAULT_PROJECT_ID
read -p 'Enter the desired region: ' SCW_DEFAULT_REGION
read -sp 'Enter your secret key: ' SCW_SECRET_KEY

curl -X POST "https://api.scaleway.com/lb/v1/regions/$SCW_DEFAULT_REGION/ips" -H "X-Auth-Token: $SCW_SECRET_KEY" -H "Content-Type: application/json" \
-d "{\"project_id\":\"$SCW_DEFAULT_PROJECT_ID\"}" | jq -r .ip_address
