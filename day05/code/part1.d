#!/usr/bin/env rdmd

import std.stdio, std.algorithm, std.array, std.conv, std.ascii, std.algorithm.searching;

void main(string[] args)
{
    auto maxv = 0;
    int[][] coords;

    foreach (line; File(args[1]).byLine.map!(v => v.replace(",", " ").split)) {
        auto c = line.map!(v => v.all!(ch => ch.to!dchar.isDigit) ? v.to!int : 0);
        coords ~= [
            min(c[0], c[3]), // x0
            min(c[1], c[4]), // y0
            max(c[0], c[3]), // x1
            max(c[1], c[4]), // y1
        ];

        // Calculation size of array
        maxv = max(maxv, c.reduce!max);
    }

    auto field = new int[][](maxv + 1, maxv + 1);

    foreach (c; coords) {
        if (c[0] == c[2] || c[1] == c[3]) {
            for (int x = c[0]; x <= c[2]; x++) {
                for (int y = c[1]; y <= c[3]; y++) {
                    field[y][x]++;
                }
            }
        }
    }

    writeln(field.join.filter!(v => v > 1).array.length);
}
