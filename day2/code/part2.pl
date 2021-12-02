use strict;
my ($x, $y, $aim);

sub forward {$x+=$_[0];$y+=$aim*$_[0]}
sub up {$aim-=shift}
sub down {$aim+=shift}

open F, $ARGV[1];
eval join ';', <F>;

print $x * $y, "\n";
