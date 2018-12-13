#!/bin/bash
set -ex

echo "Sending status ${bitbucket_build_status} to bitbucket."
URL="${BITBUCKET_STATUS_URL}/${BITRISE_GIT_COMMIT}"
BITBUCKET_STATUS=$(cat <<EOF
{
  "state": "$STATUS",
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