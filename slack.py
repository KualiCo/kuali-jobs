#!/usr/bin/env python

import requests
import json
import sys
import os


json_data = [{
    "client": "local",
    "tgt": "salt*",
    "fun": "slack.call_hook",
    "eauth": "ldap",
    "kwarg": {
        "message": "",
        "channel": "salt_noisy",
        "color": "good",
        "icon_emoji": ":aws_cb:",
        "username": "AWS CodeBuild",
        "attachment": ""
    }
}]

# Set Creds
onelogin_user = str(os.environ['ONELOGIN_USER'])
onelogin_pass = str(os.environ['ONELOGIN_PASS'])

# Set message text
json_data[0]['kwarg']['attachment'] = sys.argv[1:][0]

# Set Color
codebuild_succeeding = str(os.environ['CODEBUILD_BUILD_SUCCEEDING'])
if int(codebuild_succeeding) == 0:
    json_data[0]['kwarg']['color'] = 'danger'

# Set message header
codebuild_build_id = str(os.environ['CODEBUILD_BUILD_ID'])
codebuild_job = codebuild_build_id.split(":")[0]
url = 'https://us-west-2.console.aws.amazon.com/codebuild/home?region=us-west-2#/builds/{0}/view/new'
url = url.format(codebuild_build_id)
msg = '<{url}|{codebuild_job}>'
json_data[0]['kwarg']['message'] = msg.format(url=url, codebuild_job=codebuild_job)

if onelogin_user and onelogin_pass:
    print "Retrieved onelogin user {0}".format(onelogin_user)
    print(json.dumps(json_data, indent=2))
    json_data[0]["username"] = onelogin_user
    json_data[0]["password"] = onelogin_pass
    response = requests.post(url="https://salt-api.kuali.co/run",
                             headers={"Accept": "application/x-yaml",
                                      "Content-type": "application/json"},
                             data=json.dumps(json_data))
    print(response.text)
else:
    print "Cannot continue because creds could not be found."
