#!/bin/bash

set -x

# create project
oc login -u developer -p developer
oc new-project tenant-dep
oc create sa init-tenant

# give that service account more permissions
oc login -u system:admin
oc adm policy add-cluster-role-to-user cluster-admin system:serviceaccount:fabric8:init-tenant
oc login -u developer -p developer
