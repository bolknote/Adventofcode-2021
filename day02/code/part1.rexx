#!/usr/bin/env rexx

x = 0
y = 0

do while lines()
     parse linein op num

     select
          when op = 'forward' then x += num
          when op = 'up' then y -= num
          when op = 'down' then y += num
     otherwise
     end
end

say x * y
