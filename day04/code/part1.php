#!/usr/bin/env php
<?php
$r = file($_SERVER['argv'][1], FILE_IGNORE_NEW_LINES);

$digits = array_map('intval', explode(',', array_shift($r)));
$matrices = [];

$n = 0;
array_shift($r);

foreach ($r as $line) {
	$line = trim($line);

	if ($line === '') {
		$n++;
	} else {
		$matrices[$n][] = array_map('intval', preg_split('/\s+/', $line));
	}
}

function mark(&$m, $digit)
{
	$nulls = [];

	foreach ($m as $y => &$row) {
		foreach ($row as $x => $item) {
			if ($item === $digit) {
				$row[$x] = null;
				$nulls[] = $x;
			} elseif ($item === null) {
				$nulls[] = $x;
			}
		}

		if (count(array_filter($row, fn($it) => !is_null($it))) === 0) {
			return true;
		}
	}

	if ($nulls && max(array_count_values($nulls)) === 5) {
		return true;
	}

	return false;
}

foreach ($digits as $digit) {
	foreach ($matrices as &$m) {
		if (mark($m, $digit)) {
			$sum = array_sum(array_merge(...$m));

			print_r($sum * $digit);
			exit;
		}
	}
}
