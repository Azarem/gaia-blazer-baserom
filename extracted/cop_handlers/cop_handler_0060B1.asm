?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_01065B'
?INCLUDE 'lib_0106CD'

---------------------------------------------

Cop94_AnimTick {
    TYX                   ; {24753}
    DEC $0026, X          ; {24754}
    BPL loc_0060C0        ; {24757}
    JSL $@lib_01065B.code_01065B ; {24759}
    BCC loc_0060C6        ; {24763}
    BRL cop_handler_006473.loc_0064BF ; {24765}

  loc_0060C0:
    LDA $000E, X          ; {24768}
    STA $0014, X          ; {24771}

  loc_0060C6:
    JSL $@lib_0106CD.code_0106CD ; {24774}
    BRL cop_handler_006473.loc_0064C9 ; {24778}
}