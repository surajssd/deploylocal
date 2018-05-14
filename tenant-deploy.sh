#!/bin/bash

set -x

# create project
oc login -u developer -p developer
oc new-project tenant-dep

# deploy all the resources to the project
kedge apply -f tenant/
