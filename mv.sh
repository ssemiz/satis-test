#!/bin/bash

source_folder=$(echo "$1" | cut -f1 -d/)
source_name=$(echo "$1" | cut -f2 -d/)
source_letter=${1:0:1}

target_folder=$(echo "$2" | cut -f1 -d/)
target_name=$(echo "$2" | cut -f2 -d/)
target_letter=${2:0:1}

# copy whole folder to target
printf "copy: %s → %s\n" "$1" "$2"
cp -r "./source/$source_folder/$source_name/" "./source/$target_folder/$target_name"

# inside target folder ranme all applicable files
target_path="./source/$target_folder/$target_name/*"

# rename files inside folder
for file in $target_path; do

	# run only if it's a file, NO directories
	if [ -f "$file" ]
	then
		basename=$(basename "$file")
		new_name=$(echo "$basename" | sed "s/$source_name/$target_name/g")
		new_path="./source/$target_folder/$target_name/$new_name"

		printf "move: %s → %s\n" "$file" "$new_path"
		mv "$file" "$new_path"
	fi
done

# replace global occurences
printf "replace %s → %s\n" "$1" "$2"

grep -rl "$1" source/ | xargs sed -i "" "s#$1#$2#g"

## replace style.scss
grep -rl "$1" assets/scss/ | xargs sed -i "" "s#$1/_$source_name\.scss#$2/_$target_name\.scss#g"

## replace requireJS module
grep -rl "$1" assets/js/ | xargs sed -i "" "s#$1/$source_name#$2/$target_name#g"

# replace actual HTML/CSS names
printf "replace %s → %s\n" "$source_letter-$source_name" "$target_letter-$target_name"
grep -rl "$source_letter-$source_name" source/ | xargs sed -i "" "s/$source_letter-$source_name/$target_letter-$target_name/g"

printf "\nNow check git status and if you are sure delete %s\n\n" "$1"

