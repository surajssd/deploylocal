#!/bin/bash

if [ -z $token ]; then
    echo "Please provide the server token, by exporting variable 'token'"
    exit 1
fi

set -x

for i in `seq 1 40`; do
    curl -X POST -H "Authorization: Bearer $token" \
    -d '{ "data": { 
            "attributes": { 
                "description":"This is the foobar collaboration space",
                "name": "space_'$i'"
                },
            "type": "spaces"
            }
        }' \
    http://minishift.local:30000/api/spaces
done

