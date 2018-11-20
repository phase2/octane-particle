#!/usr/bin/env bash

# Change the git repo to the specific project url.

REPO=$1
if [[ $REPO = "" ]]; then
  read -p "Enter project git repo url: " -r REPO
  if [[ $REPO = "" ]]; then
    echo "Set your repo later using: 'bin/repo.sh REPOSITORY-URL'"
    # Remove existing origin so project doesn't accidentally push to Octane.
    git remote remove origin 2>/dev/null
    exit 0
  fi
fi

# Origin may or may not exist, so just remove and recreate it.
git remote remove origin 2>/dev/null
git remote add origin ${REPO}
