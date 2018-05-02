#!/bin/bash

if [ -z $token ]; then
    echo "Please provide the server token, by exporting variable 'token' or running export token="
    exit 1
fi

set -xe

# obtain all the spaces that are available in raw format
output=$(curl -g -L  http://minishift.local:30000/api/spaces/?page[limit]=50 -H "Authorization: Bearer $token")

# once we have that raw data now extract all the space ids
spaces=$(echo $output | jq '.data | .[] | .id' )

set +e

# iterate over all the ids so we add the codebase to all of them
for space in $spaces; do
    # these space ids have double quotes around them so get rid of it
    space=$(echo $space | tr -d '"')

    # finally now that we have all the data make that call
    curl -X POST \
      http://minishift.local:30000/api/spaces/$space/codebases \
      -H "Authorization: Bearer $token" \
      -d '{ 
            "data": { 
                "attributes": { 
                    "type": "git",
                    "url": "https://github.com/surajssd/heyheyworld"
                },
                "type": "codebases"
            }
        }'

done
