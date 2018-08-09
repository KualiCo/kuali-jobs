#!/bin/bash
SLACK_URL="https://hooks.slack.com/services/${SLACK_TOKEN}"
USERNAME="AWS CodeBuild"
ICON=":aws_cb:"
CHANNEL=${SLACK_CHANNEL:-"salt_noisy"}
REPO=${REPO:-"No repo specified.  Set Variable REPO"}
COLOR='green'
TEXT=$1
if [ $CODEBUILD_BUILD_SUCCEEDING -ne 1 ]; then COLOR='danger'; fi

echo "Using slack channel: $SLACK_CHANNEL"
echo "Using repo REPO: $REPO"
echo "Color detected as: $COLOR"
echo "Build Success? : $CODEBUILD_BUILD_SUCCEEDING"
slack_message="{
  \"username\": \"${USERNAME}\",
  \"icon_emoji\": \"${ICON}\",
  \"channel\": \"${CHANNEL}\",
  \"text\": \"${REPO}\",
  \"mrkdwn\": true,
  \"attachments\":[{
     \"color\":\"${COLOR}\" ,
     \"text\": \"${TEXT}\"
   }]
}"
curl -X POST --data-urlencode "payload=$slack_message" ${SLACK_URL}

exit 0
