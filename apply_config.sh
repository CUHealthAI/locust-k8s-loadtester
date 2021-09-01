#!/usr/bin/env bash

source config.sh

# replace markers w/actual values
if [ ! -z "$TARGET" -a ! -z "$PROJECT" ]; then
    sed -e "s/\[TARGET_HOST\]/$TARGET/g ; s/\[PROJECT_ID\]/$PROJECT/g" kubernetes-config/templates/locust-master-controller.yaml.TEMPLATE > kubernetes-config/locust-master-controller.yaml
    sed -e "s/\[TARGET_HOST\]/$TARGET/g ; s/\[PROJECT_ID\]/$PROJECT/g" kubernetes-config/templates/locust-worker-controller.yaml.TEMPLATE > kubernetes-config/locust-worker-controller.yaml

    # the service defn doesn't currently contain any vars, but let's just interpolate it anyway
    sed -e "s/\[TARGET_HOST\]/$TARGET/g ; s/\[PROJECT_ID\]/$PROJECT/g" kubernetes-config/templates/locust-master-service.yaml.TEMPLATE > kubernetes-config/locust-master-service.yaml
    
    # OS X sed creates these weird tempfiles, remove them
    # rm kubernetes-config/*.yaml-e 2>/dev/null

    echo "Done!"
else
    echo "No target set, nothing done."
fi
