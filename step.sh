#!/bin/bash
# fail if any commands fails
set -e
# debug log
set -x

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

BITBUCKET_STATUS=$(jq -n \
  --arg state       $bitbucket_build_status \
  --arg key         "BITRISE" \
  --arg url         $BITRISE_BUILD_URL \
  --arg name        "${GIT_CLONE_COMMIT_AUTHOR_NAME}" \
  --arg description "${bitbucket_build_description}" \
  '{ state: $state, key: $key, url: $url, name: $name, description: $description }'
)

echo "Sending update to $URL"
echo "New status: $bitbucket_build_status"
curl -X POST \
  $URL \
  -u $SECRET_BITBUCKET_AUTH \
  -H 'Content-Type: application/json' \
  -d "$BITBUCKET_STATUS" \
