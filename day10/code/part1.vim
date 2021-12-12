let score = 0
let map = { '{' : '}', '<' : '>', '(' : ')', '[' : ']' }
let points = { ')' : 3, ']' : 57, '}' : 1197, '>' : 25137 }

for line in readfile(argv(0))
    let stack = []
    for ch in line
        if has_key(map, ch)
            call add(stack, map[ch])
        else
            if remove(stack, -1) isnot ch
                let score += points[ch]
                break
            endif
        endif
    endfor
endfor

echo score
