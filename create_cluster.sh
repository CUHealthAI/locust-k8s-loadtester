#!/usr/bin/env bash

source config.sh

gcloud config set compute/zone ${ZONE}
gcloud config set project ${PROJECT}

# creates the cluster (assumedly it doesn't already exist)
gcloud container clusters create $CLUSTER \
   --zone $ZONE \
   --scopes $SCOPE \
   --enable-autoscaling --min-nodes "3" --max-nodes "10" \
   --scopes=logging-write,storage-ro \
   --addons HorizontalPodAutoscaling,HttpLoadBalancing

# obtain credentials for the cluster
gcloud container clusters get-credentials $CLUSTER \
   --zone $ZONE \
   --project $PROJECT
