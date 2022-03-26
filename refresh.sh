#!/bin/sh

# Refreshes list of repos from GitHub

JQ=$(which jq)
if [ -z "${JQ}" ]; then
  echo "Install JQ to continue: brew install jq" && exit 1
fi

if [ -z "${GITHUB_USERNAME}" ]; then
  echo "Define GITHUB_USERNAME to run" && exit 1
fi

if [ -z "${GITHUB_API_READ_ACCESS_TOKEN}" ]; then
  echo "Define GITHUB_API_READ_ACCESS_TOKEN to run" && exit 1
fi

PER_PAGE=100

fetch_page() {
  local ORG=$1
  local PAGE=$2

  curl -u "${GITHUB_USERNAME}:${GITHUB_API_READ_ACCESS_TOKEN}" \
    "https://api.github.com/orgs/${ORG}/repos?per_page=${PER_PAGE}&page=${PAGE}" |
    ${JQ} -r ".[].name"
}

append_list() {
  local ORG=$1
  local TEMP_FILE=$2
  local LIST=$3

  if [ "aws-amplify" = "${ORG}" ]; then
    echo "${LIST}" |
      grep -v ".github" >>${TEMP_FILE}
  fi

  if [ "awslabs" = "${ORG}" ]; then
    echo "${LIST}" |
      grep "swift\|crt" >>${TEMP_FILE}
  fi
}

append_lists() {
  local ORG=$1
  local OUTPUT_FILE=$2
  local PAGE=1
  local MAX_PAGE=100
  local DONE=false

  TEMP_FILE=$(mktemp -t $ORG)
  echo "" >${TEMP_FILE}

  until [ $PAGE -gt $MAX_PAGE -o $DONE = true ]; do
    echo "# Page ${PAGE}" >>${TEMP_FILE}
    local LIST=$(fetch_page $ORG $PAGE)
    local COUNT=$(echo "${LIST}" | wc -l | bc)

    if [ $PER_PAGE -gt $COUNT ]; then
      DONE=true
    else
      PAGE=$(expr $PAGE + 1)
    fi

    append_list "${ORG}" "${TEMP_FILE}" "${LIST}"
  done

  cat ${TEMP_FILE} | grep -v "#" | grep -v -e '^$' | sort | uniq >$OUTPUT_FILE
  rm ${TEMP_FILE}
}

append_lists aws-amplify Amplify.txt
append_lists awslabs AWSLabs.txt
