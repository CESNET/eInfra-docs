#!/bin/bash

#the script controls links, only inside the whole directory, doesnt control outside pages

for file in $@; do
check=$(cat "$file" | grep -Po "\[.*?\]\([^ ]*?\)" | grep -v "#" | grep -vE "http|@|www|ftp|none" | sed 's/\[.*\]//g' | sed 's/[()]//g' | sed 's/\/$/.md/g')
if [ ! -z "$check" ]; then

wrong=0
for line in $check; do

pathtocheck=$(dirname "$file")/$line


if [ -f $(dirname "$file")/"$line" ]; then
	:
	#echo "ok $pathtocheck"
else
	if [ $wrong -eq "0" ]; then
		echo ""
		echo "\n+++++ $file +++++\n"
	fi
	wrong=1
	echo "wrong link in $pathtocheck"

fi
done
fi
done
echo ""
