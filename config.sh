#!/usr/bin/env bash

# this file sets vars that are used in various places in the stack:
# - ./apply_config.sh: uses TARGET, LOGFILE, CUR_GIT_HASH to generate k8s object config
#   from the templates in ./kubernetes-config/templates/*.yaml.TEMPLATE
# - ./gcloud_build.sh: uses CUR_GIT_HASH to tag the locust docker image built from ./docker-image/Dockerfile
# - ./create_cluster.sh: uses GCP project config, the cluster name (CLUSTER), and scopes (SCOPE)
#   to create a k8s cluster

# standard google cloud project config
REGION=us-central1
ZONE=${REGION}-a
PROJECT="monarch-stack-loadtest"

# name of the k8s cluster that we'll use to run locust tasks
CLUSTER=monarch-load-test
# specifies access scopes for the k8s cluster
SCOPE="https://www.googleapis.com/auth/cloud-platform"

# default target host against which load will be tested (used for relative URLs in the locust tasks)
TARGET="api.monarch-test.ddns.net"
# identifies an nginx logfile to pass to logparser.py, to simulate the logfile's load
LOGFILE="/locust-tasks/profiles/logs/combined_nosim_access.log"
# used to tag docker images that we build with the hash of the latest git commit that affects the docker image
CUR_GIT_HASH=git-$( git log --pretty=tformat:"%h" -n1 ./docker-image ) # $( git rev-parse --short HEAD )
