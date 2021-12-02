#!/bin/sh

php code/part1.php input/input.txt | fgrep -c increased
php code/part2.php input/input.txt | fgrep -c increased
