#!/usr/bin/env php
<?php
$r = file($_SERVER['argv'][1], FILE_IGNORE_NEW_LINES);

$msg = [-1 => '(decreased)', '(unchanged)', '(increased)'];
$prev = null;

$cnt = count($r) - 2;
for ($i = 0; $i < $cnt; $i++) {
    $depth = array_sum(array_slice($r, $i, 3));
    echo $depth, ' ', $prev === null ? '(N/A - no previous measurement)' : $msg[$depth <=> $prev], "\n";
    $prev = $depth;
}
