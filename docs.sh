#!/bin/sh

echo "Generating: SassDoc..."
sassdoc assets/scss/ source/ -d docs/sassdoc

analyze-css --pretty --file dist/build/css/style.css > docs/css-stats.json


echo "Generating: Dependo (requireJS AST)..."
dependo -f amd ./assets/js/ source/ > docs/report-amd.html

dependo -f amd  assets/js > docs/report-amd.html
madge --format amd --require-config assets/js/main.js assets/js/ source -j > docs/ast-json.json
