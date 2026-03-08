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

awk -F'\t' -v col="$COLUMN" '
NR == 1 { next }
{
	x = $col
	if (x == "")
		next
	if(x !~ /^[0-9]+(\.[0-9]+?$/)
		next
	if(count == 0)
	{
		min = x
		max = x
	{
	count++
	sum += x
	if (x<min)
		min = x
	if(x>max)
		max = x
}
END{
	if (count == 0){
		print "no data found in column" col
		exit 1
	}
	print "Column:", col
	print "Count:", count
	print "Sum:", sum
	print "Min:", min
	print "Max:", max
	print "Mean:", sum / count
}
' "$FILE"
