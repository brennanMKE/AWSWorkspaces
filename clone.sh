#!/bin/sh

# Clones repos from lists (Amplify.txt, AWSLabs.txt)

mkdir -p Repos
cd Repos

clone_repos() {
    local ORG=$1
    local INPUT=$2
    local REPOS=$(cat ../$INPUT)
    touch ../$INPUT
    for REPO in ${REPOS}; do
        if [ ! -d "${REPO}" ]; then
            git clone git@github.com:$ORG/$REPO.git
        fi
    done
}

clone_repos aws-amplify Amplify.txt
clone_repos awslabs AWSLabs.txt
clone_repos aws-amplify Private.txt

cd ..
