#!/usr/bin/env bash
INFO_SLUG="\033[0;33m[INFO]\033[0m"
WARN_SLUG="\033[0;31m[WARN]\033[0m"

# Install packages.
if [ -e ".git" ]; then
  printf "$WARN_SLUG Project git repository already exists; cannot create new project.\n"
  exit 0
fi

printf "$INFO_SLUG Initializing repository...\n"
git init .

git add .
git commit -m "Initial commit"

#
# Clone/merge Particle repo into current directory.
#
printf "\n$INFO_SLUG Merging Particle...\n"
git remote add origin git@github.com:phase2/particle.git
# Only fetch the master branch.
git fetch origin master
# Allow merging from a different history.
# Throw away the remote commit log history.
# Allow Particle to overwrite any conflicting local files.
git merge origin/master --allow-unrelated-histories --squash --strategy-option theirs
git add .
git commit -m "Merged Particle"
git remote remove origin

#
# Clone/merge Octane repo into current directory.
#
printf "\n$INFO_SLUG Merging Octane...\n"
git remote add origin git@github.com:phase2/octane.git
# Only fetch the 8.x-4.x branch.
git fetch origin 8.x-4.x
# Allow merging from a different history.
# Throw away the remote commit log history.
# Allow Octane to overwrite any conflicting local files.
git merge origin/8.x-4.x --allow-unrelated-histories --squash --strategy-option theirs
git add .
git commit -m "Merged Octane"
git remote remove origin

# Change remote of repo to specific project.
printf "\n$INFO_SLUG Setting new repository remote...\n"
bin/repo.sh


