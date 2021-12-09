Uses
    StrUtils,
    SysUtils;

Type
    TSArray = Array of AnsiString;

Var
    F: TextFile;
    Line: String;
    Map, Words: TSArray;
    I: Word;
    Word, Str, Decoded: String;
    V0, V1, V2, V3, V4, V5, V6, V7, V8, V9,
    VA, VB, VC, VD, VE, VF, VG: String;
    Sum: Int64;

Function SortStr (Str: String): String;
Var
    Ch: Char;
    Sorted: Array Of Char;
Begin
    SetLength(Sorted, 10);
    For Ch In Str Do Sorted[Ord(Ch) - Ord('a')] := Ch;

    SortStr := '';
    For Ch In Sorted Do If Ch <> #0 Then SortStr := SortStr + Ch;
End;

Function FindByLen (Words: TSArray; Len: Byte): AnsiString;
Var
    Word: String;
Begin
    FindByLen := '';

    For Word in Words do
    Begin
        If Length(Word) = Len Then
        Begin
            FindByLen := Word;
            Break
        End
    End
End;

Function MinusStr (Word1, Word2: AnsiString): AnsiString;
Var
    Ch: Char;
Begin
    MinusStr := Word1;
    For Ch In Word2 Do
        MinusStr := ReplaceStr(MinusStr, Ch, '');

    IF Length(MinusStr) <> Length(Word1) - Length(Word2) Then
        MinusStr := ''
End;

Procedure FindLetter(Words: TSArray; MinusWord: String; var NumWord, CharWord: String);
Begin
    For NumWord In Words Do
    Begin
        CharWord := MinusStr(NumWord, MinusWord);
        If Length(CharWord) = 1 Then Exit
    End;
    NumWord := '';
    CharWord := '';
End;

Function SplitW (Str: String): TSArray;
Begin
    SplitW := SplitString(Str, ' ');
    For I := 0 To Length(SplitW) - 1 Do SplitW[I] := SortStr(SplitW[I])
End;

Begin
    Assign(F, ParamStr(1));
    Reset(F);

    Sum := 0;

    While not Eof(f) Do
    Begin
        ReadLn (F, Line);
        Words := SplitW(ReplaceStr(Line, '|', ''));

        V1 := FindByLen(Words, 2);
        V4 := FindByLen(Words, 4);
        V7 := FindByLen(Words, 3);
        V8 := FindByLen(Words, 7);

        VA := MinusStr(V7, V1);
        FindLetter(Words, V4 + VA, V9, VG);

        VE := MinusStr(V8, V9);
        FindLetter(Words, VA + VG + VE + V1, V0, VB);

        VD := MinusStr(V4, V1 + VB);
        FindLetter(Words, VA + VD + VE + VG, V2, VC);

        VF := MinusStr(V1, VC);

        V3 := VA + VC + VD + VF + VG;
        V5 := VA + VB + VD + VF + VG;
        V6 := VA + VB + VD + VE + VF + VG;

        Map := [V0, V1, V2, V3, V4, V5, V6, V7, V8, V9];
        For I := 0 To 9 Do Map[I] := SortStr(Map[I]);

        Decoded := '';

        Str := TrimLeft(Copy(Line, Pos('|', Line) + 1));
        For Word In SplitW(Str) Do
            Decoded := Decoded + IntToStr(AnsiIndexStr(Word, Map));

        Sum := Sum + StrToInt(Decoded);
    End;

    Close(F);

    WriteLn(Sum);
End.
