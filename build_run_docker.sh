#!/usr/bin/env bash

docker build -t locust-task docker-image/ && \
docker run --rm -it -p 8089:8089 \
    --env TARGET_HOST=https://monarch-test.ddns.net \
    --env LOCUST_TASK=logparser.py \
    --env LOCUST_EXTRA_ARGS="--target-logfile=/locust-tasks/profiles/logs/access.log-20210826" \
    locust-task
