#!/usr/bin/env crystal

GROUP_LEN = 5

lines = File.read_lines(ARGV[0])

numbers, boards =
    lines.shift().split(','),
    lines.reject { |x| x.empty? }.map{ |x| x.strip(" ").split(/\s+/) }.in_groups_of(GROUP_LEN)

def result(board, n)
    sum = board.flatten.map{ |x| "0#{x}".to_i }.sum
    puts sum * n.to_i

    exit
end

numbers.each{ |n|
    boards.each { |b|
        matches = [] of Int32

        b.each { |row|
            if row
                row.map_with_index! { |v, i| 
                    if v == n
                        matches << i; ""
                    else
                        v.empty? && matches << i; v
                    end
                }
                row.all? &.empty? && result(b, n)
            end
        }

        matches.group_by { |x| x }.map { |x| x[1].size }.max? == GROUP_LEN && result(b, n)
    }
}

