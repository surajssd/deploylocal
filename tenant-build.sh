#!/bin/bash

set -xe

cd $GOPATH/src/github.com/fabric8-services/fabric8-tenant
make build
docker build -t docker.io/fabric8/fabric8-tenant --file Dockerfile.deploy .
oc project tenant-dep
oc scale deploy f8tenant --replicas=0
sleep 2
oc scale deploy f8tenant --replicas=1
