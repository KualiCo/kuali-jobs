#!/bin/bash
SLACK_URL="https://hooks.slack.com/services/${SLACK_TOKEN}"
USERNAME="AWS CodeBuild"
ICON=":aws_cb:"
CHANNEL=${SLACK_CHANNEL:-"salt_noisy"}
REPO=${REPO:-"No repo specified.  Set Variable REPO"}
COLOR='good'
TEXT=$1
if [ $CODEBUILD_BUILD_SUCCEEDING -ne 1 ]; then COLOR='danger'; fi

# Set message header
ARRAY_CODEBUILD_BUILD_ID=(${CODEBUILD_BUILD_ID//:/ })
CODEBUILD_JOB=$(echo "${ARRAY_CODEBUILD_BUILD_ID[0]}")
URL="https://us-west-2.console.aws.amazon.com/codebuild/home?region=us-west-2#/builds/${CODEBUILD_BUILD_ID}/view/new"
MSG="<${URL}|${CODEBUILD_JOB}>"

echo "Using slack channel: $SLACK_CHANNEL"
echo "Using repo REPO: $REPO"
echo "Color detected as: $COLOR"
echo "Build Success? : $CODEBUILD_BUILD_SUCCEEDING"
slack_message="{
  \"username\": \"${USERNAME}\",
  \"icon_emoji\": \"${ICON}\",
  \"channel\": \"${CHANNEL}\",
  \"text\": \"${MSG}\",
  \"mrkdwn\": true,
  \"attachments\":[{
     \"color\":\"${COLOR}\" ,
     \"text\": \"${TEXT}\"
   }]
}"
curl -X POST --data-urlencode "payload=$slack_message" ${SLACK_URL}

exit 0
