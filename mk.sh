#!/bin/bash

overwrite=0

folder=$(echo "$1" | cut -f1 -d/)
name=$(echo "$1" | cut -f2 -d/)

# check if folder allready exists
if [ -d "./source/$folder/$name" ]; then
	# Control will enter here if $DIRECTORY exists.
	read -p "$(tput setaf 1)$folder/$name$(tput sgr 0) allready exists. Continue? [n/y]" -n 1 -r
	echo # (optional) move to a new line

	if [[ $REPLY =~ ^[Yy]$ ]]; then
		overwrite=1
	else
		echo "Bye! See you next time."
		exit 1
	fi
fi


# get the module name with uppercase first
ucfModule=$(sed '
  h;
  y/quvwxzdermatoglyphicsbfjkn/QUVWXZDERMATOGLYPHICSBFJKN/;
  G;
  s/\(.\)[^\n]*\n.\(.*\)/\1\2/;
' <<< "$name")

# first letter of the class (page, module, ...)
flType=${folder:0:1}

# CSS class
class="$flType-$name"

now=$(date -u +%Y-%m-%dT%H:%M:%S%z)


# create folder
mkdir -p  "./source/$folder/$name"


# create HTML

if [ "$folder" = 'pages' ]; then
	echo "<?php
\$data = (isset(\$data)) ? \$data : array(
	'heading' => '$ucfModule',
);

// include header
include(dirname(__FILE__).'/../../../layouts/header.php');

?>



<?php include(dirname(__FILE__).'/../../../layouts/footer.php'); ?>
" >> "./source/$folder/$name/$name.php"

else
	echo "<?php
\$config = [];
?>

<div class=\"$class\">
</div>
" >> "./source/$folder/$name/$name.php"
fi

# create JSON
echo "{
	\"status\": \"development\",
	\"description\": \"\",
	\"tags\": [],
	\"created\": \"$now\"
}" >> "./source/$folder/$name/$name.json"


# create JavaScript AMD module
echo 'define([], function () {
	"use strict";
    return function () {};
});' >> "./source/$folder/$name/$name.js"


# create Scss
echo "////
/// $ucfModule
///
/// @group $name
////

.$class {

}
" >> "./source/$folder/$name/_$name.scss"

# create documentation
touch "./source/$folder/$name/$name.md"


# Add new module/components to style.scss
# -i.bak is required due to OSX (http://stackoverflow.com/a/5171935/723769)
if [ $overwrite = 0 ]; then
	lf=$'\n'

	sed -i.bak "s|// <% include $folder %>|@import \"../../source/$folder/$name/_$name.scss\";\\$lf&|" assets/scss/style.scss
fi

