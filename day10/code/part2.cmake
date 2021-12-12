
# break()

file(READ ${name} lines)

# To avoid [] special meaning in cmake
string(REPLACE "[" "O" lines ${lines})
string(REPLACE "]" "C" lines ${lines})

string(REPLACE "\n" ";" lines ${lines})

function(get_pair ch)
    set(from "O;<;(;{")
    list(FIND from ${ch} idx)

    if (${idx} GREATER_EQUAL 0)
        set(to "C;>;);}")
        list(GET to ${idx} out)
    else()
        set(out "")
    endif()

    set(res ${out} PARENT_SCOPE)
endfunction()

function(score stack)
    list(REVERSE stack)
    set(lscore 0)

    set(price "_;);C;};>")

    foreach(v ${stack})
        math(EXPR lscore "${lscore}*5")
        list(FIND price ${v} idx)
        math(EXPR lscore "${lscore}+${idx}")
    endforeach()

    set(res ${lscore} PARENT_SCOPE)
endfunction()

set(scores "")

foreach(line ${lines})
    string(LENGTH ${line} len)
    math(EXPR len "${len}-1")
    set(stack "")
    set(broken 0)

    foreach(n RANGE 0 ${len})
        string(SUBSTRING ${line} ${n} 1 ch)
        get_pair(${ch})

        if("${res}" STREQUAL "")
            list(GET stack -1 last)
            if(NOT "${last}" STREQUAL "${ch}")
                set(broken 1)
                break()
            else()
                list(POP_BACK stack)
            endif()
        else()
            list(APPEND stack ${res})
        endif()
    endforeach()

    if(NOT ${broken})
        score("${stack}")
        list(APPEND scores "${res}")
    endif()
endforeach()

list(SORT scores COMPARE NATURAL)
list(LENGTH scores n)
math(EXPR n "(${n} * 10 + 5) / 20")
list(GET scores ${n} median)
message("\n${median}")
