?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_012281'
?INCLUDE 'lib_shared_012769'

!vram_upload_flags              03B8
!choice_result                  03D0

---------------------------------------------

Cop1A_ChoiceMenu {
    TYX 
    PHX 
    LDA [$38]
    INC $38
    INC $38
    TAY 
    JSL $@lib_shared_012769.code_012769
    SEP #$20
    LDA #$00
    XBA 
    LDA [$38]
    INC $38
    BNE loc_005A5D
    INC $39

  loc_005A5D:
    JSL $@lib_012281.code_012281
    PHA 
    PHP 
    LDX $03F7
    JSL $@lib_shared_012769.code_012BDA
    LDA #$01
    STA $vram_upload_flags
    PLP 
    PLA 
    REP #$20
    PLX 
    BCS loc_005A7F
    AND #$00FF
    STA $choice_result
    BRL cop_handler_006473.loc_0064BB

  loc_005A7F:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_handler_006473.loc_0064C1
}