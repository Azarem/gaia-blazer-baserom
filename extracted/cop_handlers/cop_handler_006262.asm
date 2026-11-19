?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

CopA5_JumpByFlipState {
    TYX 
    LDA $001C, X
    PHA 
    AND #$3FFF
    STA $001C, X
    PLA 
    LDY #$0000
    AND #$C000
    BEQ loc_006286
    INY 
    INY 
    CMP #$4000
    BEQ loc_006286
    INY 
    INY 
    CMP #$8000
    BEQ loc_006286
    INY 
    INY 

  loc_006286:
    LDA [$38], Y
    BRL cop_handler_006473.loc_0064C1
}