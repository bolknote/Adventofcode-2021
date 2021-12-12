#!/bin/sh

/usr/bin/env -- vim -eRn -c 'redir >> /dev/stdout' -S $(dirname "$0")/code/part1.vim -c q $(dirname "$0")/input/input.txt
/usr/bin/env cmake -Dname=$(dirname "$0")/input/input.txt -P $(dirname "$0")/code/part2.cmake
