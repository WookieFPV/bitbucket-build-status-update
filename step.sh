#!/bin/bash
# Fail on error and unset variables
set -eu

# Debug mode
if [[ "$is_debug_mode" == "yes" ]]; then
  set -x
  echo "Debug log enabled"
fi

# Determine Bitbucket build status
if [[ "$bitbucket_build_status" == "AUTO" ]]; then
  echo "Selected AUTO bitbucket_build_status"
  bitbucket_build_status="FAILED"

  # Use more robust integer comparison
  if [[ "$BITRISE_BUILD_STATUS" -eq 0 ]]; then
    bitbucket_build_status="SUCCESSFUL"
  fi
fi

# Bitbucket API URL
url="${bitbucket_status_url}/${git_clone_commit_hash}"

# Construct the JSON payload
build_status_json=$(jq -n \
  --arg state "$bitbucket_build_status" \
  --arg key "${build_key}" \
  --arg url "$BITRISE_BUILD_URL" \
  --arg name "${build_name}" \
  --arg description "${bitbucket_build_description}" \
  '{ state: $state, key: $key, url: $url, name: $name, description: $description }')

# Output for debugging
echo "Sending update to: $url"
echo "New status: $bitbucket_build_status"
if [[ "$is_debug_mode" == "yes" ]]; then
  echo "JSON Payload: $build_status_json"
fi

# Send the status to Bitbucket
curl -X POST \
  "$url" \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer ${bitbucket_access_token}" \
  -d "$build_status_json"

echo "Bitbucket status update sent."
