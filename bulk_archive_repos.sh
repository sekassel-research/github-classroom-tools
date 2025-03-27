function github_repo_archive(){
  local repo="$1"

  local url="https://api.github.com/repos/$repo"

  echo -n $'\e[34mUPDATE\e[0m' "$url: "

  # https://docs.github.com/de/rest/repos/repos?apiVersion=2022-11-28#update-a-repository
  curl -L \
    -X PATCH \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $GITHUB_TOKEN" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "$url" \
    -d '{"archived":true}'\
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
    "$url" \
    | jq '.message // "ok"'
}

repos=$(cat ./repos.txt)
students=$(cat ./students.txt)

for repo in $repos
do
  for student in $students
  do
    github_delete_collaborator "$repo-$student" "$student"
    github_repo_archive "$repo-$student"
  done
done
