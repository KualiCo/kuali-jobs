#!/bin/bash

USERNAME="AWS CodeBuild"
ICON=":aws_cb:"

CHANNEL="#salt_noisy"
TEXT_HEADER='667650582711.dkr.ecr.us-west-2.amazonaws.com/mkt-jobs'
TEXT="Docker Image XXXXXX has been pushed to the repository"
# "good" or "danger"
COLOR="good"

SLACK_TOKEN=$(aws ssm get-parameters \
  --region us-west-2 \
  --names slack_token \
  --with-decryption \
  --query Parameters[0].Value \
  --output text)
SLACK="https://hooks.slack.com/services/${SLACK_TOKEN}"

attachments="{ \"color\": \"good\", \"text\": \"${TEXT}\" }"
slack_message="{
  \"username\": \"${USERNAME}\",
  \"icon_emoji\": \"${ICON}\",
  \"channel\": \"${CHANNEL}\",
  \"text\": \"${TEXT_HEADER}\",
  \"mrkdwn\": true,
  \"attachments\":[{
     \"color\":\"${COLOR}\" ,
     \"text\": \"${TEXT}\"
   }]
}"
curl -X POST --data-urlencode "payload=$slack_message" ${SLACK}

exit 0


# slack_notify.sh "good" "Docker Image XXXXXX has been pushed to the repository" ${SLACK} ${CHANNEL}
