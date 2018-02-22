#!/bin/bash

set -x

export MINISHIFT_HOSTS_ENTRY=http://minishift.local
export MINISHIFT_URL=http://$(getent hosts minishift.local | awk '{ print $1 }')

oc login -u developer -p developer 
oc new-project wit-dep

export F8_DEVELOPER_MODE_ENABLED=true 
export F8_POSTGRES_HOST=$MINISHIFT_HOSTS_ENTRY
export F8_POSTGRES_PORT=32000 
export AUTH_DEVELOPER_MODE_ENABLED=true 
export AUTH_WIT_URL=$MINISHIFT_HOSTS_ENTRY:30000 
export AUTH_IMAGE_URL=docker.io/fabric8/fabric8-auth

kedge apply -f wit-deploy/db.yml -f wit-deploy/db-auth.yml -f wit-deploy/auth.yml

# Create WIT pod
export F8_AUTH_URL=$MINISHIFT_URL:31000 
export F8_DEVELOPER_MODE_ENABLED=true 
export F8_POSTGRES_HOST=$MINISHIFT_HOSTS_ENTRY
export F8_POSTGRES_PORT=32000 
export AUTH_DEVELOPER_MODE_ENABLED=true 
export AUTH_WIT_URL=$MINISHIFT_HOSTS_ENTRY:30000 
export WIT_IMAGE_URL=fabric8/fabric8-wit

kedge apply -f wit-deploy/wit.yml
