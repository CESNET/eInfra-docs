#!/bin/bash
VER=$(git log --pretty=format:'/ ver. %h / %ai' -n 1)
sed "s,__VERSION__, $VER," mkdocs.yml -i
YEAR=$(date +"%Y")
sed "s,__YEAR__, $YEAR," mkdocs.yml -i
