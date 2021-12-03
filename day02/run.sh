#!/bin/sh

$(dirname "$0")/code/part1.rexx < $(dirname "$0")/input/input.txt
$(dirname "$0")/code/part2.pl -- $(dirname "$0")/input/input.txt
