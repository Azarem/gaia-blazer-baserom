?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_027462_part1'

---------------------------------------------

Cop29_JumpIfTileIdDiffers {
    TYX 
    LDA $0000, X
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0010
    STA $18
    PHX 
    JSL $@lib_027462_part1.code_0272B8
    SEP #$20
    LDA [$38]
    INC $38
    BNE loc_005C09
    INC $39

  loc_005C09:
    CMP $7E8000, X
    REP #$20
    BNE loc_005C15
    PLX 
    BRL cop_handler_006473.loc_0064BB

  loc_005C15:
    PLX 
    LDA [$38]
    INC $38
    INC $38
    BRL cop_handler_006473.loc_0064C1
}