#!/bin/bash

set -x

project=sentry
oc new-project $project
kedge apply -f sentry-deploy/
oc expose svc sentry
oc get all
