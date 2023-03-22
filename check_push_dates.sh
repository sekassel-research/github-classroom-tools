#!/usr/bin/env bash
org=$1
prefix=$2
date=$3

./fetch_repo_names.sh "$org" "$prefix" | while read name; do
  ./fetch_push_dates.sh "$org" "$prefix$name" "$date"
done
