#!/bin/sh

# Refreshes list of repos from GitHub

JQ=$(which jq)

if [ -z "${JQ}" ]; then
    echo "Install JQ to continue: brew install jq"
    return
fi

curl "https://api.github.com/orgs/aws-amplify/repos?per_page=100" | \
    ${JQ} -r ".[].name" | \
    grep -v ".github" | \
    sort | uniq > Amplify.txt

curl "https://api.github.com/orgs/awslabs/repos?per_page=100&page=1" | \
    ${JQ} -r ".[].name" | \
    grep "swift\|crt" | \
    sort | uniq > AWSLabs.txt

curl "https://api.github.com/orgs/awslabs/repos?per_page=100&page=2" | \
    ${JQ} -r ".[].name" | \
    grep "swift\|crt" | \
    sort | uniq >> AWSLabs.txt

curl "https://api.github.com/orgs/awslabs/repos?per_page=100&page=3" | \
    ${JQ} -r ".[].name" | \
    grep "swift\|crt" | \
    sort | uniq >> AWSLabs.txt

curl "https://api.github.com/orgs/awslabs/repos?per_page=100&page=4" | \
    ${JQ} -r ".[].name" | \
    grep "swift\|crt" | \
    sort | uniq >> AWSLabs.txt

curl "https://api.github.com/orgs/awslabs/repos?per_page=100&page=5" | \
    ${JQ} -r ".[].name" | \
    grep "swift\|crt" | \
    sort | uniq >> AWSLabs.txt
