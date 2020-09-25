#!/usr/bin/env bash

curl --request POST \
--url "http://${XLR_HOST}/webhooks/gitlab-sample-webhook" \
--header 'Content-Type: application/json' \
--header 'X-Gitlab-Event: Push Hook' \
--data '@../xlr-webhooks-samples/gitlab/push_event.json'
