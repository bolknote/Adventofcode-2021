#!/usr/bin/env tclsh

set fd [open [lindex $argv 0]]
set lines [split [read $fd] "\n"]
close $fd

set result [split [string map {1 0} [lindex $lines 1]] {}]

foreach line $lines {
    set bits [split $line {}]

    set i 0; foreach bit $bits {
        set op [string map {"0" "+" "1" "-"} $bit]
        lset result $i [expr [lindex $result $i] $op 1]
        incr i
    }
}

set gamma ""
set epsilon ""

foreach r $result {
    append gamma [expr $r < 0]
    append epsilon [expr $r > 0]
}

puts [expr "0b$gamma * 0b$epsilon"]
