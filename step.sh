#!/bin/bash
# fail if any commands fails
set -e
# debug log
if [ "$is_debug_mode" == "yes" ]
then
  set -x
  echo "debug log enabled"
fi

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
URL="${bitbucket_status_url}/${git_clone_commit_hash}"

BITBUCKET_STATUS=$(jq -n \
  --arg state       $bitbucket_build_status \
  --arg key         "${build_key}" \
  --arg url         $BITRISE_BUILD_URL \
  --arg name        "${build_name}" \
  --arg description "${bitbucket_build_description}" \
  '{ state: $state, key: $key, url: $url, name: $name, description: $description }'
)

echo "Sending update to $URL"
echo "New status: $bitbucket_build_status"
curl -X POST \
  $URL \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer ${bitbucket_access_token}" \
  -d "$BITBUCKET_STATUS" \
