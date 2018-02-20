#/bin/bash

set -e

UI_IMAGE_REF=$(gcloud container images list-tags --format='get(digest)' --filter=tags:latest eu.gcr.io/blockchain-js/blockchain-js-ui)
RENCONTRES_IMAGE_REF=$(gcloud container images list-tags --format='get(digest)' --filter=tags:latest eu.gcr.io/blockchain-js/rencontres)

echo "ui : $UI_IMAGE_REF"
echo "rencontres : $RENCONTRES_IMAGE_REF"

cat application.yaml | \
    sed "s|blockchain-js-ui:latest|blockchain-js-ui@${UI_IMAGE_REF}|g" | \
    sed "s|rencontres:latest|rencontres@${RENCONTRES_IMAGE_REF}|g" | \
    kubectl apply -f -