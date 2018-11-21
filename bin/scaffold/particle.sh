#!/usr/bin/env bash
# Generate project files for Particle.
INFO_SLUG="\033[0;33m[INFO]\033[0m"

copy_files=(
  ".browserslistrc"
  ".editorconfig"
  ".eslintignore"
  ".eslintrc.js"
  ".prettierignore"
  ".prettierrc.js"
  ".stylelintignore"
  ".stylelintrc"
  "package.json"
)

printf "$INFO_SLUG Copying files for Particle...\n"
for file in "${copy_files[@]}"
do
  cp packages/particle/${file} .
done

mkdir -p src/themes/particle
cp -R packages/particle/apps/drupal/ src/themes/particle/
