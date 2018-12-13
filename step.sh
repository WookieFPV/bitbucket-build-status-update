#!/bin/bash
set -ex

echo "Sending status ${bitbucket_build_status} to bitbucket."
URL="${bitbucket_status_url}/${BITRISE_GIT_COMMIT}"
BITBUCKET_STATUS=$(cat <<EOF
{
  "state": "$bitbucket_build_status",
	"key": "BITRISE",
	"url": "$bitbucket_status_url"
}
EOF
)

echo $URL
echo $BITBUCKET_STATUS
# curl -X POST \
#   $URL \
#   -u $BITBUCKET_AUTH \
#   -H 'Content-Type: application/json' \
#   -d "$BITBUCKET_STATUS" \