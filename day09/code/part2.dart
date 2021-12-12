#!/usr/bin/env dart run

import 'dart:io';

extension on List {
    bool equals(List list) {
        if (this.length != list.length) return false;

        for (var i = 0; i < this.length; i++) {
            if (this[i] != list[i]) return false;
        }

        return true;
    }
}

main(args) {
    new File(args[0]).readAsLines()
    .then(readLines)
    .then(findLowestPoints)
    .then((p) => getBasins(p[0], p[1]))
    .then(calcResult)
    .then(print);
}

readLines(lines) {
    return [...lines.map((line) => [...line.split('').map(int.parse)])];
}

getAround(field, x, y) {
    final w = field[0].length;
    final h = field.length;

    return [
        if (x > 0) [x - 1, y],
        if (x < w - 1) [x + 1, y],
        if (y > 0) [x, y - 1],
        if (y < h - 1) [x, y + 1],
    ];
}

allGreater(val, field, coords) {
    return [...coords].every((c) => field[c[1]][c[0]] > val);
}

findLowestPoints(field) {
    var lowest = [];

    for (var y = 0; y < field.length; y++) {
        for (var x = 0; x < field[y].length; x++) {
            final coords = getAround(field, x, y);
            final val = field[y][x];

            if (allGreater(val, field, coords)) {
                lowest.add([x, y]);
            }
        }
    }

    return [field, lowest];
}

getBasins(field, lowest) {
    return lowest.map((point) => floodFill(field, point[0], point[1], []).length);
}

floodFill(field, x, y, stack) {
    if (field[y][x] != 9 && !stack.any((e) => [...e].equals([x, y]))) {
        stack.add([x, y]);
        for (final c in getAround(field, x, y)) {
            stack = floodFill(field, c[0], c[1], stack);
        }
    }

    return stack;
}

calcResult(basins) {
    return ([...basins]..sort((a, b) => b - a)).sublist(0, 3).reduce((a, b) => a * b);
}
