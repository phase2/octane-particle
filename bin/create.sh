#!/usr/bin/env bash
INFO_SLUG="\033[0;33m[INFO]\033[0m"
WARN_SLUG="\033[0;31m[WARN]\033[0m"

if [ -e ".git" ]; then
  printf "$WARN_SLUG Project git repository already exists; cannot create new project.\n"
  exit 0
fi

# Download packages.
git clone git@github.com:phase2/particle.git packages/particle
git clone git@github.com:phase2/octane.git packages/octane

# Run any generators.
generators=`ls bin/generators`
for package in "${generators[@]}"
do
  printf "$INFO_SLUG Generating ${package}...\n"
  bin/generators/${package}
done

printf "$INFO_SLUG Initializing repository...\n"
git init .
bin/repo.sh


