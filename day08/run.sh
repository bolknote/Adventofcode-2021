#!/bin/sh

$(dirname "$0")/code/part1.sh < $(dirname "$0")/input/input.txt

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
NAME=$(/usr/bin/mktemp -d)
cd "$NAME"
cp "$SCRIPT_DIR/code/part2.pas" .
fpc part2.pas >/dev/null && ./part2 "$SCRIPT_DIR/input/input.txt"
cd - >&-
/bin/rm -rf "$NAME"
