#!/usr/bin/env bash

############################################################################
# https://hub.docker.com/r/atlassian/bitbucket-server
#
docker run --name="bitbucket" -it -p 7990:7990 -p 7999:7999 atlassian/bitbucket-server
