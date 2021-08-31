#!/usr/bin/env bash

source config.sh

DO_CHECKOUT=1

# replace markers w/actual values
if [ ! -z "$TARGET" -a ! -z "$PROJECT" ]; then
    if [ "${DO_CHECKOUT}" -eq 1 ]; then
      echo "Checking out config files..."
      git checkout f919a6c85a30ccd55da157b7c86b64a060ac22c1 -- kubernetes-config/*.yaml
    fi

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
