?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0064F8'

!inventory                      1B1E

---------------------------------------------

Cop0B_ClearInventoryEntry {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&engine_0064F8.code_00651E
    BCS loc_0058A6
    SEP #$20
    BPL loc_00589E
    AND #$7F
    STZ $1B64

  loc_00589E:
    EOR $inventory, Y
    STA $inventory, Y
    REP #$20

  loc_0058A6:
    BRL cop_handler_006473.loc_0064BF
}