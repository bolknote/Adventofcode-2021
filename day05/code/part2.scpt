#!/usr/bin/osascript

on min(x, y)
    if x < y then
        x
    else
        y
    end
end

on max(x, y)
    if x > y then
        x
    else
        y
    end
end

on step(c1, c2)
	if c1 is c2 then
		0
	else
		1
	end
end

on run argv
	set DEBUG to true

    set fname to (item 1 of argv) as string
    set lns to paragraphs of (read POSIX file fname)
    
    set field to {}
    set coords to {}
    set dim to 0

    set AppleScript's text item delimiters to ","
    repeat with l in lns
    	try
	        set cs to every text item of l
    	    set mid to words of (item 2 of cs)
    	on error
    		exit repeat
    	end try

        set x1 to min(1, 2)

        set x1 to min(item 1 of cs, item 3 of mid)
        set x2 to max(item 1 of cs, item 3 of mid)

        set y1 to min(item 1 of mid, item 3 of cs)
        set y2 to max(item 1 of mid, item 3 of cs)

        set end of coords to {x1 + 1, y1 + 1, x2 + 1, y2 + 1}
        set dim to max(dim, max(x2, y2)) as number
    end repeat

    set dim to dim + 1

    repeat dim times
	    set row to {}
	    repeat dim times
	    	set end of row to 0
	    end repeat

    	set end of field to row
    end

    if DEBUG then log "Created"

    set sum to 0

    repeat with c in coords
    	set x1 to item 1 of c
    	set y1 to item 2 of c
    	set x2 to item 3 of c
    	set y2 to item 4 of c

        set x to x1
        set y to y1

        set step_x to step(x1, x2)
        set step_y to step(y1, y2)

        repeat
        	if x >= x2 and y >= y2 then exit repeat

        	set x to x + step_x
        	set y to y + step_y

        	set current to item x of item y of field

        	if current < 2 then
    			set item x of item y of field to current + 1
    			if current is 1 then set sum to sum + 1
    		end
        end repeat

        if DEBUG then log "Drawn: " & x1 & ", " & y1 & " -> " & x2 & ", " & y2
    end repeat

    log sum
end run
