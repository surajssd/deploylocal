#!/bin/bash

set -x

export MINISHIFT_HOSTS_ENTRY=http://minishift.local
export MINISHIFT_URL=http://$(getent hosts minishift.local | awk '{ print $1 }')

oc login -u developer -p developer 
oc new-project wit-dep

kedge apply -f wit-deploy/db.yml

# Create WIT pod
export F8_AUTH_URL=$MINISHIFT_URL:31000 
export WIT_IMAGE_URL=fabric8/fabric8-wit

kedge apply -f wit-deploy/wit.yml
