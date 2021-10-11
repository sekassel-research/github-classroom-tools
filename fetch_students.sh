#!/bin/bash

USERNAME=$1
ORG=$2
PREFIX=$3

PAGE_COUNT=$(
  curl -sI -u "$USERNAME:$GITHUB_SECRET" "https://api.github.com/orgs/$ORG/repos" |
    sed -n -r 's/^link:.*<[^>]*page=([0-9]+)>; rel="last".*$/\1/ip'
)

for ((i = 1; i <= PAGE_COUNT; i++)); do
  curl -s \
    -H "Accept: application/vnd.github.v3+json" \
    -u "$USERNAME:$GITHUB_SECRET" \
    "https://api.github.com/orgs/$ORG/repos?page=$i" |
    jq -r ".[] | select(.name|startswith(\"$PREFIX-\")) | .name" |
    sed -r "s/$PREFIX-(.*)/\1/"
done
