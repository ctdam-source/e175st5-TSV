#!/bin/bash

if [[ $# -ne 2 ]]; then
	echo "Usage: $0 <tsv> <column_number>"
	exit 1
fi

FILE="$1"
COLUMN="2"

if [[ ! -f "$FILE" ]];trhen
	echo "'$FILE' not found"
	exit 1
fi

if ! [[ "$COLUMN" =~ ^[0-9]+$ ]]; then
	echo "must be a number"
	exit 1
fi 
