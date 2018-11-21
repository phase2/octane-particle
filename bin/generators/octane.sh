#!/usr/bin/env bash
# Generate project files for Octane
INFO_SLUG="\033[0;33m[INFO]\033[0m"

copy_files=(
  "composer.json"
)

printf "$INFO_SLUG Copying files for Octane...\n"
for file in "${copy_files[@]}"
do
  cp packages/octane/${file} .
done

printf "$INFO_SLUG Merging scripts...\n"
cp -R packages/octane/src/ src/
rsync -abuP packages/octane/.docksal/commands/ .docksal/commands/
rsync -abuP packages/octane/.docksal/addons/ .docksal/addons/
rsync -abuP packages/octane/bin/ bin/
