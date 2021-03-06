#!/usr/bin/env bash

dir="$(dirname "${BASH_SOURCE[0]}")/.."
# Copy ES6 source file
cp $dir/src/image-upload.js $dir/index.js
# Copy the template
cp $dir/src/es5-wrapper.js $dir/image-upload.min.js
# Compile to ES5
js=$(node $dir/node_modules/babel-cli/bin/babel.js $dir/src/image-upload.js --presets=es2015 | $dir/node_modules/uglify-js/bin/uglifyjs -m)
echo $js > tmp.js
# Wrap
sed -i -e '/MINIFIED_JS/r tmp.js' -e '/MINIFIED_JS/d' $dir/image-upload.min.js
rm tmp.js