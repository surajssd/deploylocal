#!/bin/bash

set -x

sudo systemctl start docker
sudo systemctl --no-pager status docker
oc cluster up --public-hostname=$(getent hosts minishift.local | awk '{ print $1 }')
