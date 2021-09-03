#!/usr/bin/env bash

source config.sh

gcloud builds submit \
    --tag gcr.io/$PROJECT/locust-tasks:$CUR_GIT_HASH docker-image
