?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_01065B'
?INCLUDE 'lib_0106CD'

---------------------------------------------

Cop95_AnimTickRepeat {
    TYX                   ; {24781}
    DEC $0026, X          ; {24782}
    BPL loc_0060E1        ; {24785}

  loc_0060D3:
    JSL $@lib_01065B.code_01065B ; {24787}
    BCC loc_0060E7        ; {24791}
    DEC $002A, X          ; {24793}
    BNE loc_0060D3        ; {24796}
    BRL cop_handler_006473.loc_0064BF ; {24798}

  loc_0060E1:
    LDA $000E, X          ; {24801}
    STA $0014, X          ; {24804}

  loc_0060E7:
    JSL $@lib_0106CD.code_0106CD ; {24807}
    BRL cop_handler_006473.loc_0064C9 ; {24811}
}