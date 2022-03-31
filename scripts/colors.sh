#!/bin/bash
for i in {"red","pink","purple","deep purple","indigo","blue","light blue","cyan","teal","green","light green","lime","yellow","amber","orange","deep orange","brown","grey","blue grey"}
do
  echo "Setting color to: $i, ${i/ /_}, color_${i/ /_}"
  git checkout color_${i/ /_}
  git pull --rebase origin colors
  git pull --rebase 
  sed -ri "s/(primary: ').*'/\1$i'/" mkdocs.yml
  git commit -am "Setting color to: $i"
  git push --set-upstream origin color_${i/ /_}
  git checkout colors
done
