#!/bin/bash

: '
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/

Copyright 2019 J.D. Bean
'

function github_repo_transfer(){
  local repo="$1"
  local new_owner="$2"

  local url="https://api.github.com/repos/$repo/transfer"

  echo -n $'\e[34mTRANSFER\e[0m' "$url: "

  # https://developer.github.com/v3/repos/#transfer-a-repository
  curl -L \
    -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $GITHUB_TOKEN" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    $url \
    -d '{"new_owner":"'$new_owner'"}'
    | jq '.message // "ok"'
}

function github_delete_collaborator(){
  local repo="$1"
  local collaborator="$2"

  local url="https://api.github.com/repos/$repo/collaborators/$collaborator"

  echo -n $'\e[31mDELETE\e[0m' "$url: "

  # https://developer.github.com/v3/repos/collaborators/#remove-a-repository-collaborator
  curl -L \
    -X DELETE \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $GITHUB_TOKEN" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    $url
    | jq '.message // "ok"'
}

new_owner="$1"
repos=$(cat ./repos.txt)
students=$(cat ./students.txt)

for repo in $repos
do
  for student in $students
  do
    github_delete_collaborator "$repo-$student" "$student"
    github_repo_transfer "$repo-$student" "$new_owner"
  done
done
