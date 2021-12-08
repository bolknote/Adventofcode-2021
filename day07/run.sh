#!/bin/sh

/usr/bin/env gawk -f $(dirname "$0")/code/part1.awk < $(dirname "$0")/input/input.txt

NAME=$(/usr/bin/mktemp)
valac -o "$NAME" $(dirname "$0")/code/part2.vala >/dev/null && "$NAME" $(dirname "$0")/input/input.txt
/bin/rm -rf "$NAME"
