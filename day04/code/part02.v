#!/usr/bin/env v run
import os
import io
import regex
import strconv

const group_len = 5

fn result(b [][]string, n string) {
    mut sum := 0
    for v in b {
        sum += v.map(
            fn(v string) int {
                return strconv.atoi(v) or {0}
            }
        ).reduce(
            fn(a int, b int) int {
                return a + b
            },
        0)
    }

    println(sum * strconv.atoi(n) or {0})
    exit(0)
}

fn main() {
    mut fd := os.open(os.args[1])?
    defer {
        fd.close()
    }

    mut br := io.new_buffered_reader(reader: fd)

    mut numbers := br.read_line()?.split(",")
    br.read_line()?

    mut num_re, _, _ := regex.regex_base("\\d+")

    mut boards := [][][]string{}
    {
        mut board := [][]string{}

        for {
            if line := br.read_line() {
                if line == "" {
                    boards << board
                    board = []
                } else {
                    board << [num_re.find_all_str(line)]
                }
            } else {
                boards << board
                break
            }
        }
    }

    mut filled_boards := boards.len

    for n in numbers {
        for mut board in boards {
            mut col_empties := []int{}

            for mut row in board {
                mut row_empties := 0

                for x, mut v in row {
                    if v == n {
                        v = ""
                        row_empties++
                        col_empties << x
                    } else if v == "" {
                        row_empties++
                        col_empties << x
                    }
                }
                
                if row_empties == group_len {
                    if filled_boards-- < 2 {
                        result(board, n)
                    }
                    board = []
                }

            }

            mut empty_cols_cnt := [group_len]int{}
            for y in col_empties {
                empty_cols_cnt[y]++

                if empty_cols_cnt[y] == group_len {
                    if filled_boards-- < 2 {
                        result(board, n)
                    }
                    board = []
                }
            }
        }
    }

    println(boards)
}