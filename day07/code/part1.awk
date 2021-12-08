function abs(x) {
    return x < 0 ? -x : x
}

BEGIN {
    RS=","
}

{
    v[NR]=$1
    if (min > $1) min=$1
    if (max < $1) max=$1
}

END {
    for (t = min; t <= max; t++) {
        fuel = 0
        for (i = 1; i <= NR; i++) fuel += abs(v[i] - t)
        if (!minfuel || minfuel > fuel) minfuel = fuel
    }

    print minfuel
}
