#!/bin/bash
set -ex

if [ $bitbucket_build_status -eq "AUTO" ];then
  bitbucket_build_status="FAILED"
  if [ "$BITRISE_BUILD_STATUS" -eq "1" ];then
    STATUS="SUCCESSFUL"
  fi
fi
# printenv
echo "Sending status ${bitbucket_build_status} to bitbucket."
URL="${bitbucket_status_url}/${GIT_CLONE_COMMIT_HASH}"
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