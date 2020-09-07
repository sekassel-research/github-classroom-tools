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
	local user="$1"
	local repo="$2"
	local new_owner="$3"
	# https://developer.github.com/v3/repos/#transfer-a-repository
  curl -L \
  	-u "$user:${GITHUB_SECRET}" \
    -H "Content-Type: application/json" \
    -H "Accept: application/vnd.github.nightshade-preview+json" \
    -X POST "https://api.github.com/repos/$repo/transfer" \
    -d '{"new_owner":"'"$new_owner"'"}' \
    | jq .
}

function github_delete_collaborator(){
	local user="$1"
	local repo="$2"
	local collaborator="$3"
	# https://developer.github.com/v3/repos/collaborators/#remove-a-repository-collaborator
  curl -L \
  	-u "$user:${GITHUB_SECRET}" \
    -X DELETE "https://api.github.com/repos/$repo/collaborators/$collaborator"
}

user="$1"
new_owner="$2"
repos=$( cat ./repos.txt)
collaborators=$( cat ./collaborators.txt)

for repo in $repos
do
	for collaborator in $collaborators
	do
		github_delete_collaborator "$owner" "$repo" "$collaborator"
	done
	github_repo_transfer "$owner" "$repo" "$new_owner"
done
