function abs(x) {
    return x > 0 ? x : -x;
}

BEGIN {
    RS=","
}

{
    v[NR] = $1
    sum += $1
}

END {
    asort(v)
    median = v[rshift(NR, 1)]

    fuel = 0
    for (i in v) fuel += abs(median - v[i])

    print fuel
}
