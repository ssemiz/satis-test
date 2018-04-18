#!/bin/bash

NORMAL=$(tput sgr0)
YELLOW=$(tput setaf 3)

folder=$(echo "$1" | cut -f1 -d/)
name=$(echo "$1" | cut -f2 -d/)
letter=${1:0:1}

# check if folder allready exists
if [ ! -d "./source/$folder/$name" ]; then
	printf "Pattern ${YELLOW}%s${NORMAL} does not exist.\n" "$1"
	exit 1
fi



# copy whole folder to target
printf "checking if module is still in use…\n"

# check for i()
num_includes=$(grep -rlo "$1" source/ | wc -l)
if [[ $num_includes -gt 0 ]] ; then
	echo "You have  $num_includes i($1) calls in your code."
	exit 1
fi

# check for HTML/CSS classes outside module itself
num_classes=$(find source -path "source/$1" -prune -o -type f -name "*" -exec grep -l "$letter-$name" {} \; |wc -l)

if [[ $num_classes -gt 0 ]] ; then
	echo "You have $num_classes classes $letter-$name in your code."
	exit 1
fi

## replace style.scss
num_sassincludes=$(grep -rlo --include="*.scss" "$1" assets/scss/ | wc -l)
if [[ $num_sassincludes -gt 1 ]] ; then
	printf "You have more than one (%s) Scss include of the module %s in your code." "$num_sassincludes" "$1"
	exit 1
fi

echo "Removing include from .scss files"
grep -rl "$1" assets/scss/ | xargs sed -i "" "/$folder\/$name/d"

## remove requireJS module
##grep -rl "$1" assets/js/ | xargs sed -i "" "s#$1/$source_name#$2/$target_name#g"

## Delete module folder
printf "Deleting module folder at ${YELLOW}%s${NORMAL}" "$1"
rm -rf "source/$1"


printf "\n\nPattern ${YELLOW}%s${NORMAL} sucessfully removed. You can now commit your changes.\n\n" "$1"

