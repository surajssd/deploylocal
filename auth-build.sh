#!/bin/bash

cd $GOPATH/src/github.com/fabric8-services/fabric8-auth

set -x

make bin/docker/fabric8-auth-linux
make fast-docker

oc -n auth-dep scale deploy auth --replicas=0
sleep 2
oc -n auth-dep scale deploy auth --replicas=1
