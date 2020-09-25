#!/usr/bin/env bash

curl --request POST \
--url "http://${XLR_HOST}/webhooks/bitbucket-sample-webhook" \
--header 'Content-Type: application/json' \
--header 'X-Event-Key: repo:push' \
--data '@./bitbucket_push.json'
