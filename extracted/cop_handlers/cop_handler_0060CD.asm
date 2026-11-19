?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_01065B'
?INCLUDE 'lib_0106CD'

---------------------------------------------

Cop95_AnimTickRepeat {
    TYX 
    DEC $0026, X
    BPL loc_0060E1

  loc_0060D3:
    JSL $@lib_01065B.code_01065B
    BCC loc_0060E7
    DEC $002A, X
    BNE loc_0060D3
    BRL cop_handler_006473.loc_0064BF

  loc_0060E1:
    LDA $000E, X
    STA $0014, X

  loc_0060E7:
    JSL $@lib_0106CD.code_0106CD
    BRL cop_handler_006473.loc_0064C9
}