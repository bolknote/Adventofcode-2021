use strict;
my ($x, $y);

sub forward {$x+=shift}
sub up {$y-=shift}
sub down {$y+=shift}

open F, $ARGV[1];
eval join ';', <F>;

print $x * $y, "\n";
