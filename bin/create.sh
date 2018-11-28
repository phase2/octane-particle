#!/usr/bin/env bash
INFO_SLUG="\033[0;33m[INFO]\033[0m"
WARN_SLUG="\033[0;31m[WARN]\033[0m"

if [ -e ".git" ]; then
  printf "$WARN_SLUG Project git repository already exists; cannot create new project.\n"
  exit 0
fi

# Download packages.
mkdir packages
git clone git@github.com:phase2/particle.git packages/particle
git clone -b feature/particle git@github.com:phase2/octane.git packages/octane

# Scaffold the packages.
for package in bin/scaffold/*
do
  printf "$INFO_SLUG Scaffolding ${package}...\n"
  ${package}
done

# Run generators
printf "$INFO_SLUG Running generators...\n"
if [ ! -e "node_modules/.bin/yo" ]; then
  npm install --save-dev yo yeoman-generator
fi
./node_modules/.bin/yo ./bin/generators/create-project/index.js

# Pull in any environment variables set by generators.
source .env

if [[ ${PROJECT_REPO} != "" ]]; then
  printf "$INFO_SLUG Initializing repository...\n"
  git init .
  bin/repo.sh ${PROJECT_REPO}
else
  printf "$INFO_SLUG Set your repo later using: 'bin/repo.sh REPOSITORY-URL'\n"
fi
