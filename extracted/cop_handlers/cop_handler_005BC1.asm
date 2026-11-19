?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_027462_part1'

!tile_type_map                  7F8000

---------------------------------------------

Cop28_JumpIfTileHere {
    TYX 
    LDA $0000, X
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0010
    STA $18

  loc_005BD0:
    PHX 
    JSL $@lib_027462_part1.code_0272B8
    LDA $tile_type_map, X
    PLX 
    AND #$00FF
    BNE loc_005BE2
    BRL cop_handler_006473.loc_0064BB

  loc_005BE2:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_handler_006473.loc_0064C1
}