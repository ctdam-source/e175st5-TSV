#!/bin/bash
set -u

SCRIPT="./column_stats.sh"
PASS=0
FAIL=0

cat > sample.tsv <<EOF
sample	depth	quality
S1	30	40.5
S2	45	38.2
S3	12	42.1
S4	28	35.0
EOF

cat > expected1.txt <<EOF
Column: 2
Count: 4
Sum: 115
Min: 12
Max: 45
Mean: 28.75
EOF

$SCRIPT sample.tsv 2 > output1.txt 2>&1

if diff -u expected1.txt output1.txt > /dev/null; then
	echo "Test 1 pass"
	((PASS++))
else
	echo "Test 1 fail"
	((FAIL++))
fi

cat > edge.tsv <<EOF
sample	depth
S1	30
S2	abc
S3	
S4	20
EOF

cat > expected2.txt <<EOF
Column: 2
Count: 2
Sum: 50
Min: 20
Max: 30
Mean: 25
EOF

$SCRIPT edge.tsv 2 > output2.txt 2>&1

if diff expected2.txt output2.txt > /dev/null;then
        echo "Test 2 pass"
        ((PASS++))
else
        echo "Test 2 fail"
        ((FAIL++))
fi

cat > expected3.txt << EOF
Error: file 'missing.tsv' not found
EOF

$SCRIPT missing.tsv 2 > output3.txt 2>&1

if diff expected3.txt output3.txt > /dev/null; then
    echo "Test 3 PASS"
    ((PASS++))
else
    echo "Test 3 FAIL"
    ((FAIL++))
fi

echo
echo "Tests Passed: $PASS"
echo "Tests Failed: $FAIL"
