#!/usr/bin/env bash

source config.sh

# replace markers w/actual values
if [ ! -z "$TARGET" -a ! -z "$PROJECT" ]; then
    git checkout -- kubernetes-config/*.yaml

    sed -i -e "s/\[TARGET_HOST\]/$TARGET/g" kubernetes-config/locust-master-controller.yaml
    sed -i -e "s/\[TARGET_HOST\]/$TARGET/g" kubernetes-config/locust-worker-controller.yaml
    sed -i -e "s/\[PROJECT_ID\]/$PROJECT/g" kubernetes-config/locust-master-controller.yaml
    sed -i -e "s/\[PROJECT_ID\]/$PROJECT/g" kubernetes-config/locust-worker-controller.yaml

    # OS X sed creates these weird tempfiles, remove them
    rm kubernetes-config/*.yaml-e 2>/dev/null

    echo "Done!"
else
    echo "No target set, nothing done."
fi
