#!/usr/bin/env bash

REGION=us-central1
ZONE=${REGION}-a
PROJECT="monarch-stack-loadtest"
CLUSTER=monarch-load-test
TARGET="api.monarch-test.ddns.net"
LOGFILE="/locust-tasks/profiles/logs/combined_nosim_access.log"
SCOPE="https://www.googleapis.com/auth/cloud-platform"
CUR_GIT_HASH=git-$( git rev-parse --short HEAD )
