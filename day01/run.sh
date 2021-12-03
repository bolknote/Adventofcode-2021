#!/bin/sh

$(dirname "$0")/code/part1.dc < $(dirname "$0")/input/input.txt | fgrep -c increased
$(dirname "$0")/code/part2.php  $(dirname "$0")/input/input.txt | fgrep -c increased
