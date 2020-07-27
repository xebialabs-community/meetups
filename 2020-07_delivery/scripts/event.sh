#!/bin/bash

set -x

SUBVER="5"

curl 'https://xlr.rbroker.linkpc.net/webhooks/d3e33cb60f08844029435a776ab6cd9c' -k -i -X POST \
-H 'Content-Type: application/json' \
-H 'Accept: application/json' \
-d "{ \"version\": \"5.${SUBVER}\",
  \"application\": \"portalUI\"
}"

sleep 4

curl 'https://xlr.rbroker.linkpc.net/webhooks/d3e33cb60f08844029435a776ab6cd9c' -k -i -X POST \
-H 'Content-Type: application/json' \
-H 'Accept: application/json' \
-d "{ \"version\": \"1.${SUBVER}\",
  \"application\": \"profileService\"
}"

sleep 4

curl 'https://xlr.rbroker.linkpc.net/webhooks/d3e33cb60f08844029435a776ab6cd9c' -k -i -X POST \
-H 'Content-Type: application/json' \
-H 'Accept: application/json' \
-d "{ \"version\": \"3.${SUBVER}\",
  \"application\": \"loginService\"
}"

sleep 4

curl 'https://xlr.rbroker.linkpc.net/webhooks/d3e33cb60f08844029435a776ab6cd9c' -k -i -X POST \
-H 'Content-Type: application/json' \
-H 'Accept: application/json' \
-d "{ \"version\": \"2.${SUBVER}\",
  \"application\": \"newsService\"
}"

sleep 4

curl 'https://xlr.rbroker.linkpc.net/webhooks/d3e33cb60f08844029435a776ab6cd9c' -k -i -X POST \
-H 'Content-Type: application/json' \
-H 'Accept: application/json' \
-d "{ \"version\": \"1.${SUBVER}\",
  \"application\": \"calendarService\"
}"


