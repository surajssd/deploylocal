#!/bin/bash

set -xe

cd $GOPATH/src/github.com/fabric8-services/fabric8-wit
make build
docker build -t docker.io/fabric8/fabric8-wit --file Dockerfile.deploy .
oc project wit-dep
oc scale deploy wit --replicas=0
sleep 2
oc scale deploy wit --replicas=1
