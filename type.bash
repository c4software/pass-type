#!/bin/bash

local delay=3
local auto_submit=0

usage() {
	echo "Usage: pass type [-a] [-d] pass-name";
	echo "    -a: Auto-submit the password (default false)";
	echo "    -d: Delay before « typing » the passmord (default 3s)";
}

while getopts ":ad:" opt; do
  case ${opt} in
    a )
      auto_submit=1
      ;;
    d )
      delay=$OPTARG
      ;;
    \? )
      usage;
      exit 1;
      ;;
  esac
done
shift $(expr $OPTIND - 1 )

local path="$1"
local passfile="$PREFIX/$path.gpg"
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
        if [[ $auto_submit -eq 1 ]]
        then
            osascript -e "tell application \"System Events\" to key code 52"    
        fi
    else
        xdotools type "$temporary"
        if [[ $auto_submit -eq 1 ]]
        then
            xdotool key KP_Enter    
        fi
    fi
elif [[ -z $path ]]; then
    die ""
else
    die "Error: $path is not in the password store."
fi
