#!/usr/bin/env bash
org=$1
repo=$2
date=$3

curl -s -H "Authorization: token $GITHUB_TOKEN" "https://api.github.com/repos/$org/$repo/events" |
  jq -r '
  sort_by(.created_at)
| .[]
| select(.type == "PushEvent")
| select(.created_at > "'"$date"'")
| .created_at,(.payload.commits | .[] | "- \(.sha[0:7])\t\(.author.name)\t\(.message)")
'
