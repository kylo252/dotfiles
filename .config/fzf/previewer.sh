#!/usr/bin/env bash

function fuzzy_search_open_file_preview() {
	if [ $# -ne 2 ]
	then
		return 1
	fi
	local search=$1
	local file=$2
	local last=-1
	local range=''
	local highl=''
	# get all ranges in the current file
	for match in $(rg -i --line-number --context 2 -F "$search" "$file" | sed 's/^\([0-9]*:*\).*/\1/')
	do
		line=${match//:/}
		if [ "$match" != "$line" ]; then
			highl+="-H $line "
		fi
		if [ $last -eq -1 ]; then
			range="-r $line:"
		elif [ ! "$line" -eq $((last + 1)) ]; then
			range+="$last"
			range+=" -r $line:"
		fi

		last=$line
	done
	if [ "$last" -eq -1 ]; then
		return
	else
		range+="$last"
	fi
	eval "bat $file --color=always $range $highl"
}

fuzzy_search_open_file_preview "$@"
