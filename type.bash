#!/bin/bash

local path="$1"
local passfile="$PREFIX/$path.gpg"
local delay=3
check_sneaky_paths "$path"

if [[ -f $passfile ]]; then
    local temporary=$($GPG -d "${GPG_OPTS[@]}" "$passfile" | tail -n +1 | head -n 1 | sed -e 's/\\/\\\\/g' | sed -e 's/"/\\"/g' )

    while [ $delay -gt 0 ]; do
        echo -ne "The password will be type in $delay seconds.\033[0K\r"
        sleep 1
        delay=$((delay-1))
    done

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