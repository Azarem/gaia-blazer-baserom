?BANK 00

?INCLUDE 'cop_handler_006473'

!map_width_px                   0342
!map_height_px                  0344

---------------------------------------------

CopAD_YieldWhileInView {
    TYX 
    LDA $0016, X
    BIT #$8000
    BNE loc_00637F
    BRL cop_handler_006473.loc_0064BD

  loc_00637F:
    LDA $0000, X
    CMP $map_width_px
    BCC loc_00638A
    BRL cop_handler_006473.loc_0064BD

  loc_00638A:
    LDA $0002, X
    CMP $map_height_px
    BCC loc_006395
    BRL cop_handler_006473.loc_0064BD

  loc_006395:
    LDA $38
    DEC 
    DEC 
    STA $0018, X
    LDA [$38]
    INC $38
    AND #$00FF
    STA $0014, X
    BRL cop_handler_006473.loc_0064C9
}