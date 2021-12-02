<?php
$r = fn() => yield from file($_SERVER['argv'][1], FILE_IGNORE_NEW_LINES);

$msg = [-1 => '(decreased)', '(unchanged)', '(increased)'];
$prev = null;

foreach ($r() as $depth) {
    echo $depth, ' ', $prev === null ? '(N/A - no previous measurement)' : $msg[$depth <=> $prev], "\n";
    $prev = $depth;
}
