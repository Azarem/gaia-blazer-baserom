?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_012281'
?INCLUDE 'lib_014F02'
?INCLUDE 'lib_shared_012769'

!vram_upload_flags              03B8

---------------------------------------------

Cop02_PromptFixedString {
    TYX 
    PHX 
    LDY #$&lib_014F02.asciistring_014F02
    JSL $@lib_shared_012769.code_012769
    SEP #$20
    LDA #$00
    XBA 
    LDA #$02
    JSL $@lib_012281.code_012281
    PHP 
    LDX $03F7
    JSL $@lib_shared_012769.code_012BDA
    LDA #$01
    STA $vram_upload_flags
    PLP 
    REP #$20
    PLX 
    BCS loc_0057EC
    AND #$00FF
    BNE loc_0057EC
    BRL cop_handler_006473.loc_0064BB

  loc_0057EC:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_handler_006473.loc_0064C1
}