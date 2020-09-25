#!/usr/bin/env bash

curl --request POST \
--url "http://${XLR_HOST}/webhooks/jython-webhook?token=s3cr3t" \
--header 'Content-Type: application/json' \
--header 'Auth-Token: salt:passw0rd' \
--data '@../xlr-webhooks-samples/gitlab/push_event.json'
