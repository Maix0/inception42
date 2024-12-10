#!/usr/bin/env bash

# ./<script_name> <file> <KEYNAME> <prompt> <fill_password>

FILE="$1"
KEY="$2"
PROMPT="$3"

# replace KEY VALUE
replace() {
	key=$(printf "%s\n" "$1" | sed -e 's/[\/&]/\\&/g')
	val=$(printf "%s\n" "$2" | sed -e 's/[\/&]/\\&/g')
	sed -e "s/^$key=\$/\0$val/" -i "${SECRET_DIR}/${FILE}.env"
}

if [ -n "$4" ]; then
	val="$(dd if=/dev/urandom bs=32 count=1 2>/dev/null | base64 | tr -d -- '\n' | tr -- '+/' '-_'; echo)"
	replace "$KEY" "$val"
	exit 0;
fi

printf "\x1b[32m%s? \x1b[0m>\x1b[0m" "$PROMPT"
if read -er val && [ -n "$val" ]; then
	replace "$KEY" "$val"
else
	echo "missing $PROMPT"
	exit 1
fi
