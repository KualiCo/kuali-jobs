#!/usr/bin/env python

import requests
import json
import sys
import os


def get_definition(json_file):
    """
    Reads a local json document and returns the content.
    """
    data = None
    with open(json_file) as json_data:
        data = json.load(json_data)
    return data


json_file = sys.argv[1:][0]
onelogin_user = str(os.environ['ONELOGIN_USER'])
onelogin_pass = str(os.environ['ONELOGIN_PASS'])

if onelogin_user and onelogin_pass:
    print "Retrieved onelogin user {0}".format(onelogin_user)
    print "Launching definition {0}".format(json_file)
    json_def = get_definition(json_file)
    print(json.dumps(json_def, indent=2))
    json_def[0]["username"] = onelogin_user
    json_def[0]["password"] = onelogin_pass
    response = requests.post(url="https://salt-api.kuali.co/run",
                             headers={"Accept": "application/x-yaml",
                                      "Content-type": "application/json"},
                             data=json.dumps(json_def))
    print(response.text)
else:
    print "Cannot continue because creds could not be found."
