#!/bin/bash

temp_dir_name="temp_$(date +'%Y%m%d%H%M%S')"
url_boilerplate="https://github.com/dbserver/boilerplate-automacao-api-java.git"
boilerplate_file_name="boilerplate"
target_branch="main"
challenge_description=$'\n'$(grep -A 6 "# Desafio Automação DBBank" "README.md")
challenge_description+=$'\n\n'$(grep -A 100000 "## Desafio" "README.md")

mkdir "$temp_dir_name"

git clone --branch "$target_branch" --depth 1 "$url_boilerplate" "$temp_dir_name"

(cd "$temp_dir_name" && git archive --format=zip --output="$boilerplate_file_name".zip "$target_branch")

unzip -o -qq "$temp_dir_name"/"$boilerplate_file_name".zip -d .

echo "$challenge_description" >> README.md

rm -rf "$temp_dir_name"
