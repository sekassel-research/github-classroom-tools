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

function github_repo_rename(){
  local repo="$1"
  local new_name="$2"

  local url="https://api.github.com/repos/$repo"

  echo -n $'\e[34mRENAME\e[0m' "$url: "

  # https://docs.github.com/en/rest/reference/repos#update-a-repository
  curl -sL \
    -H "Authorization: Bearer $GITHUB_TOKEN" \
    -H "Content-Type: application/json" \
    -H "Accept: application/vnd.github.nightshade-preview+json" \
    -X PATCH "$url" \
    -d '{"name":"'"$new_name"'"}' \
    | jq '.message // "ok"'
}

old_name="$1"
new_name="$2"
students=$(cat ./students.txt)

for student in $students
do
  github_repo_rename "$old_name-$student" "$new_name-$student"
done
