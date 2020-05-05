#!/usr/bin/env bash

notmuch new --quiet

if [[ -f "$@" ]] ; then
    notmuch tag --batch --input="$@"
fi
