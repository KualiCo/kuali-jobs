#!/bin/bash

# SLACK_TOKEN=$(aws ssm get-parameters \
#   --region us-west-2 \
#   --names slack_token \
#   --with-decryption \
#   --query Parameters[0].Value \
#   --output text)
SLACK_TOKEN=${SLACK_TOKEN:-"Slack token not specified."}
SLACK="https://hooks.slack.com/services/${SLACK_TOKEN}"
USERNAME="AWS CodeBuild"
ICON=":aws_cb:"
CHANNEL=${SLACK_CHANNEL:-"ops-kcs"}
echo "Using slack channel: $SLACK_CHANNEL"
REPO=${REPO:-"No repo specified.  Set Variable REPO"}
echo "Using repo REPO: $REPO"

TEXT=$1
COLOR=$2

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
curl -X POST --data-urlencode "payload=$slack_message" ${SLACK}

exit 0


# slack_notify.sh "good" "Docker Image XXXXXX has been pushed to the repository" ${SLACK} ${CHANNEL}
