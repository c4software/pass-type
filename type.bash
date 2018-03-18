#!/bin/bash

local path="$1"
local passfile="$PREFIX/$path.gpg"
local delay=3
check_sneaky_paths "$path"

if [[ -f $passfile ]]; then
    local temporary=$($GPG -d "${GPG_OPTS[@]}" "$passfile" | tail -n +1 | head -n 1 | sed -e 's/\\/\\\\/g' | sed -e 's/"/\\"/g' )
    echo "The password will be type in $delay seconds"
    sleep $delay
    if [[ `uname` == 'Darwin' ]]
    then
        osascript -e "tell application \"System Events\" to keystroke \"$temporary\""
    else
        xdotools type "$temporary"
    fi
elif [[ -z $path ]]; then
    die ""
else
    die "Error: $path is not in the password store."
fi
