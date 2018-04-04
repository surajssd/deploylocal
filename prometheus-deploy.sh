#!/bin/bash

set -e

export APP_URL=wit:8080
export APP_NAME=wit

project=$(oc project | awk '{print $3}')
echo "Deploying to project: $project"

kedge apply -f prometheus/prometheus.yml

url=$(oc get routes | grep prometheus | awk '{print $2}')

echo
echo "visit http://$url"
