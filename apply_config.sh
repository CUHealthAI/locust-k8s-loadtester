#!/usr/bin/env bash

source config.sh

# replace markers w/actual values
if [ ! -z "$TARGET" -a ! -z "$PROJECT" ]; then
    EDIT_CMDS="s/\[TARGET_HOST\]/$TARGET/g ; s/\[PROJECT_ID\]/$PROJECT/g ; s/\[IMAGE_TAG\]/$CUR_GIT_HASH/g"

    sed -e "$EDIT_CMDS" kubernetes-config/templates/locust-master-controller.yaml.TEMPLATE > kubernetes-config/locust-master-controller.yaml
    sed -e "$EDIT_CMDS" kubernetes-config/templates/locust-worker-controller.yaml.TEMPLATE > kubernetes-config/locust-worker-controller.yaml
    # the service defn doesn't currently contain any vars, but let's just interpolate it anyway
    sed -e "$EDIT_CMDS" kubernetes-config/templates/locust-master-service.yaml.TEMPLATE > kubernetes-config/locust-master-service.yaml
    
    # OS X sed creates these weird tempfiles, remove them
    # rm kubernetes-config/*.yaml-e 2>/dev/null

    echo "Done!"
else
    echo "No target set, nothing done."
fi
