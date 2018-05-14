#!/bin/bash

set -x

export MINISHIFT_HOSTS_ENTRY=http://minishift.local
export MINISHIFT_URL=http://$(getent hosts minishift.local | awk '{ print $1 }')

# give that user account more permissions
oc login -u system:admin
oc adm policy add-cluster-role-to-user cluster-admin developer
oc login -u developer -p developer

oc new-project auth-dep
token=$(echo -n $(oc whoami -t) | gpg --passphrase tenantsecretNew --symmetric --cipher-algo AES256 | base64 -w0)
cat > /tmp/oso-clusters.conf <<EOF
{
    "clusters": [
        {
            "name":"samecluster",
            "api-url":"https://kubernetes.default:443",
            "app-dns":"https://kubernetes.default",
            "service-account-username":"developer",
            "service-account-token":"$token",
            "capacity-exhausted":false,

            "token-provider-id":"f867ac10-5e05-4359-a0c6-b855ece59090",
            "auth-client-id":"autheast2",
            "auth-client-secret":"autheast2secret",
            "auth-client-default-scope":"user:full"
        }
    ]
}
EOF

oc create cm clusters --from-file=/tmp/oso-clusters.conf

export AUTH_WIT_URL=$MINISHIFT_HOSTS_ENTRY:30000
# export AUTH_IMAGE_URL=docker.io/fabric8/fabric8-auth
export AUTH_IMAGE_URL=fabric8/fabric8-auth:dev

kedge apply -f auth-deploy/db-auth.yml -f auth-deploy/auth.yml
