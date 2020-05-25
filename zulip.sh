#! /usr/bin/env bash
CSS=`node_modules/css-color-extractor-cli/cli.js dist/themes/zulip-dark.css --format=css --color-format hslString`
CSS=`echo "$CSS" | sed 's/  [ ]*\(.*\)/    \1/'`
CSS=`echo "$CSS" | sed 's/\(.*\)/    \1/'`

OUTPUT="dist/themes/zulip-dark.scss"
LOCATION="static/third/flatpickr/flatpickr.scss"
VERSION=$(cat package.json \
  | grep version \
  | head -1 \
  | awk -F: '{ print $2 }' \
  | sed 's/[",]//g')

DOCSTRING="/*
    flatpickr.scss

    This file contains night-mode theme for flatpickr. We leverage the flatpickr
    project's work to generate themes cleanly. However, since they use stylus as
    their CSS langauge, our systems aren't directly compatible.

    We build this file by running:

    $ git clone git@github.com:aero31aero/flatpickr.git
    $ cd flatpickr
    $ git checkout zulip
    $ npm install
    $ npm run build
    $ # This file has been generated at $OUTPUT.
    $ cp $OUTPUT ../zulip/$LOCATION

    This is somewhat convoluted and we should decide on a better strategy, or just
    roll our own theme, but this method allows us to stay up-to-date with upstream.

    Theme built for:$VERSION
*/
"


SCSS="$DOCSTRING
@mixin night {
$CSS
}"
echo "$SCSS" > $OUTPUT
