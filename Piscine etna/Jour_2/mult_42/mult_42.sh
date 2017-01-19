#!/bin/bash
# (()) = utiliser pour calcule
while IFS=: read -r f1 f2 f3 f4 f5 f6 f7
do 	
if (( "$f3" % 42 == 0 )); then
	echo "$f1"
fi
done < passwd
