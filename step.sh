#!/bin/bash
set -ex

echo "commit $commit"
echo "$BITRISE_GIT_COMMIT"
echo "Sending status ${bitbucket_build_status} to bitbucket."
URL="${bitbucket_status_url}/${commit}"
BITBUCKET_STATUS=$(cat <<EOF
{
  "state": "$bitbucket_build_status",
	"key": "BITRISE",
	"url": "$BITRISE_BUILD_URL"
}
EOF
)

echo $URL
echo $BITBUCKET_STATUS
curl -X POST \
  $URL \
  -u $BITBUCKET_AUTH \
  -H 'Content-Type: application/json' \
  -d "$BITBUCKET_STATUS" \