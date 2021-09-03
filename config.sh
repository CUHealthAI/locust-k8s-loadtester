#!/usr/bin/env bash

REGION=us-central1
ZONE=${REGION}-a
PROJECT="monarch-stack-loadtest"
CLUSTER=monarch-load-test
TARGET="monarch-test.ddns.net"
SCOPE="https://www.googleapis.com/auth/cloud-platform"
CUR_GIT_HASH=git-$( git rev-parse --short HEAD )
