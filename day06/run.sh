#!/bin/sh

focal-81 <<CMD | /usr/bin/awk '{print $NF}'
lib call $(dirname "$0")/code/part1.fcl
goto
$(/usr/bin/awk -F, '{print NF;for (i=1;i<=NF;i++)print$i}' $(dirname "$0")/input/input.txt)
CMD

#NAME=$(/usr/bin/mktemp -d)
#rlc -o "$NAME" $(dirname "$0")/code/part2 >/dev/null && "$NAME" < $(dirname "$0")/input/input.txt
#/bin/rm -rf "$NAME"
