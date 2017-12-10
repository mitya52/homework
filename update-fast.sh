#!/bin/bash

if [[ $# != 0 ]]; then
	echo "Usage: $0"
fi

function list_me_pls() {
	DIR=$1
	find $DIR/ -type f | xargs md5sum | sort | sed 's|'$DIR'/||'
}

for FILE in `comm -23 <(list_me_pls data) <(list_me_pls fast-data) | awk '{print $2}'`; do
	mkdir -p fast-data/`dirname $FILE`
	cp data/$FILE fast-data/$FILE
	echo "copied new file data/$FILE"
done
