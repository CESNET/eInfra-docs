#!/bin/bash

### DOWNLOAD AND CONVERT DOCUMENTATION
# autor: kru0052
# version: 1.00 
###

if [ "$1" = "-w" ]; then
	# download html pages 
	rm -rf docs-old.it4i.cz
	wget -X portal_css,portal_javascripts,++resource++jquery-ui-themes,anselm-cluster-documentation/icon.jpg -R favicon.ico,pdf.png,logo.png,background.png,application.png,search_icon.png,png.png,sh.png,touch_icon.png,anselm-cluster-documentation/icon.jpg,*js,robots.txt,*xml,RSS,download_icon.png,@@*,anselm-cluster-documentation/icon.jpg.1 --mirror --convert-links --adjust-extension --page-requisites  --no-parent https://docs-old.it4i.cz;
fi
if [ "$1" = "-c" ]; then
	# erasing the previous transfer
	if [ -d ./docs.it4i ]; then
			rm -rf ./docs.it4i
	fi
	if [ -d ./info ]; then
			rm -rf ./info;
	fi
	
	# counter for html and md files	
	counter=1
	count=$(find . -name "*.html" -type f | wc -l)
	
	find . -name "*.ht*" | 
	while read i; 
	do 
		# filtering html files
		echo "$(tput setaf 12)($counter/$count)$(tput setaf 11)$i"; 
		counter=$((counter+1))
		printf "\t\tFiltering html files...\n";

		HEAD=$(grep -n -m1 '<h1' "$i" |cut -f1 -d: | tr --delete '\n')
		END=$(grep -n -m1 '<!-- <div tal:content=' "$i" |cut -f1 -d: | tr --delete '\n')
		LAST=$(wc -l "$i" | cut -f1 -d' ')
		DOWN=$((LAST-END+2))

		sed '1,'"$((HEAD-1))"'d' "$i" | sed -n -e :a -e '1,'"$DOWN"'!{P;N;D;};N;ba' > "${i%.*}TMP.html"	
		
		# converted .html to .md
		printf "\t\t.html => .md\n"
		pandoc -f html -t markdown+pipe_tables-grid_tables "${i%.*}TMP.html" -o "${i%.*}.md"; 
		
		rm "${i%.*}TMP.html"
	done
	
	# delete empty files
	find -type f -size -10c | 
	while read i; 
	do
		rm "$i"; 	
		echo "$(tput setaf 9)$i deleted"; 
	done
fi
