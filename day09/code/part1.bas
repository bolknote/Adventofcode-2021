#!/usr/bin/env cbmbasic

05 REM WE DOESN'T HAVE ENOUGH MEMORY :(
10 DIM F(3, 100): Y = 0: SUM = 0
20 DEF FN T(LY) = LY - INT(LY / 3) * 3
30 GOSUB 100: IF X = 0 THEN GOTO 60
35 GOSUB 300: IF X = 0 THEN GOTO 60
40 GOSUB 400
50 Y = Y + 1: GOTO 35
60 GOSUB 400: PRINT SUM
90 REM GOSUB 1000
99 END

100 REM READ LINE
105 X=0
110 GET I$
120 IF ST <> 0 OR I$=CHR$(255) OR I$=CHR$(13) THEN RETURN
130 F(FN T(Y), X) = VAL(I$) + 1
140 X=X+1
150 GOTO 110

300 REM READ NEXT LINE
310 Y = Y + 1: GOSUB 100
320 Y = Y - 1: RETURN

400 REM CALCULATE
410 FOR X = 0 TO 99: C = F(FN T(Y), X)
420 IF C = 0 THEN RETURN
430 GOSUB 500: IF RET THEN SUM = SUM + C
440 NEXT
450 RETURN

500 REM CHECK MIN
505 RET = 0
510 IF X > 0  THEN IF F(FN T(Y), X-1) <= C AND F(FN T(Y), X-1) <> 0 THEN RETURN
520 IF X < 99 THEN IF F(FN T(Y), X+1) <= C AND F(FN T(Y), X+1) <> 0 THEN RETURN
530 IF Y > 0  THEN IF F(FN T(Y-1), X) <= C AND F(FN T(Y-1), X) <> 0 THEN RETURN
540 IF Y < 99 THEN IF F(FN T(Y+1), X) <= C AND F(FN T(Y+1), X) <> 0 THEN RETURN
550 RET = 1
560 RETURN

999 REM PRINT LINES
1000 FOR LY = 0 TO 2: FOR X = 0 TO 99
1005 IF F(LY, X) <> 0 THEN PRINT F(LY, X);
1010 NEXT X: PRINT: NEXT LY
1020 RETURN
