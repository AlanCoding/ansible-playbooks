#!/usr/bin/env bash

TMPFILE='random'$RANDOM
touch $TMPFILE
git add $TMPFILE
git commit -m "Adding temporary file $TMPFILE"
git rm $TMPFILE
git commit -m "Removing temporary file $TMPFILE"
