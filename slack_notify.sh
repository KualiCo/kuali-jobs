#!/bin/bash
if [ $CODEBUILD_BUILD_SUCCEEDING -eq 1 ] ; then
    COLOR='good'
else
    COLOR='danger'
fi
SLACK_URL="https://hooks.slack.com/services/${SLACK_TOKEN}"
USERNAME="AWS CodeBuild"
ICON=":aws_cb:"
CHANNEL=${SLACK_CHANNEL:-"salt_noisy"}
REPO=${REPO:-"No repo specified.  Set Variable REPO"}
TEXT=$1

echo "Using slack channel: $SLACK_CHANNEL"
echo "Using repo REPO: $REPO"
attachments="{ \"color\": \"good\", \"text\": \"${TEXT}\" }"
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
exit 1
