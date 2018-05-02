#!/bin/bash

cd $GOPATH/src/github.com/fabric8-services/fabric8-auth

set -x

make bin/docker/fabric8-auth-linux
make fast-docker