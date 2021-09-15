#!/usr/bin/env bash

source config.sh

# first, check if the cluster's running and boot it up if not
if ( gcloud container clusters list | grep $CLUSTER > /dev/null ); then
    echo "* Cluster $CLUSTER exists, continuing..."
else
    echo "* Setting up cluster $CLUSTER..."
    ./create_cluster.sh
fi

./k8s_command.sh delete 2>/dev/null ; ./gcloud_build.sh && ./apply_config.sh && ./k8s_command.sh && \
    kubectl get service --watch
