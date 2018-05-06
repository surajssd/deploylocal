#!/bin/bash

set -x

export MINISHIFT_HOSTS_ENTRY=http://minishift.local
export MINISHIFT_URL=http://$(getent hosts minishift.local | awk '{ print $1 }')

oc login -u developer -p developer 
oc new-project auth-dep

export AUTH_WIT_URL=$MINISHIFT_HOSTS_ENTRY:30000 
export AUTH_IMAGE_URL=docker.io/fabric8/fabric8-auth

kedge apply -f auth-deploy/db-auth.yml -f auth-deploy/auth.yml
