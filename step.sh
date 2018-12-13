#!/bin/bash
# set -ex

if [ "$bitbucket_build_status" = "AUTO" ];then
  echo "Selected AUTO bitbucket_build_status"
  bitbucket_build_status="FAILED"
  echo "Setting build status to successful? ${BITRISE_BUILD_STATUS}"
  if [ "$BITRISE_BUILD_STATUS" -eq "0" ];then
    bitbucket_build_status="SUCCESSFUL"
  fi
fi
# printenv
echo "Sending status ${bitbucket_build_status} to bitbucket."
URL="${bitbucket_status_url}/${GIT_CLONE_COMMIT_HASH}"
BITBUCKET_STATUS=$(cat <<EOF
{
  "state": "$bitbucket_build_status",
	"key": "BITRISE",
	"url": "$BITRISE_BUILD_URL",
  "name": "$GIT_CLONE_COMMIT_AUTHOR_NAME",
  "description": "$GIT_CLONE_COMMIT_MESSAGE_BODY"
}
EOF
)

echo "Sending update to $URL"
curl -X POST \
  $URL \
  -u $SECRET_BITBUCKET_AUTH \
  -H 'Content-Type: application/json' \
  -d "$BITBUCKET_STATUS" \