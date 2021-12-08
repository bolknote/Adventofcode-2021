#!/bin/sh

/usr/bin/env gawk -f $(dirname "$0")/code/part1.awk < $(dirname "$0")/input/input.txt
