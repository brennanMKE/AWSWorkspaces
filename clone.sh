#!/bin/sh

# Clones repos from lists (Amplify.txt, AWSLabs.txt)

touch Amplify.txt
touch AWSLabs.txt
touch Private.txt

AMPLIFY_REPOS=$(cat Amplify.txt)
AWS_REPOS=$(cat AWSLabs.txt)
PRIVATE_REPOS=$(cat Private.txt)

pushd .
mkdir -p Repos
cd Repos
pwd

 for AMPLIFY_REPO in ${AMPLIFY_REPOS}; do 
     if [ ! -d "${APPLE_REPO}" ]; then
         git clone git@github.com:aws-amplify/$AMPLIFY_REPO.git
     fi
 done

for AWS_REPO in ${AWS_REPOS}; do 
    if [ ! -d "${AWS_REPO}" ]; then
        git clone git@github.com:awslabs/$AWS_REPO.git
    fi
done

for PRIVATE_REPO in ${PRIVATE_REPOS}; do
    if [ ! -d "${PRIVATE_REPO}" ]; then
        git clone git@github.com:aws-amplify/$PRIVATE_REPO.git
    fi
done

popd
