#!/usr/bin/env bash

if [[ -x ~/.mail/scripts/notmuch-post-sync-hook.bash ]] ; then
    ~/.mail/scripts/notmuch-post-sync-hook.bash "$@"
fi
