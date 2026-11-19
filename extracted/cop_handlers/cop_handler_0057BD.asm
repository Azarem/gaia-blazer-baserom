?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_012281'
?INCLUDE 'lib_014F02'
?INCLUDE 'lib_shared_012769'

!vram_upload_flags              03B8

---------------------------------------------

Cop02_PromptFixedString {
    TYX                   ; {22461}
    PHX                   ; {22462}
    LDY #$&lib_014F02.asciistring_014F02 ; {22463}
    JSL $@lib_shared_012769.code_012769 ; {22466}
    SEP #$20              ; {22470}
    LDA #$00              ; {22472}
    XBA                   ; {22474}
    LDA #$02              ; {22475}
    JSL $@lib_012281.code_012281 ; {22477}
    PHP                   ; {22481}
    LDX $03F7             ; {22482}
    JSL $@lib_shared_012769.code_012BDA ; {22485}
    LDA #$01              ; {22489}
    STA $vram_upload_flags ; {22491}
    PLP                   ; {22494}
    REP #$20              ; {22495}
    PLX                   ; {22497}
    BCS loc_0057EC        ; {22498}
    AND #$00FF            ; {22500}
    BNE loc_0057EC        ; {22503}
    BRL cop_handler_006473.loc_0064BB ; {22505}

  loc_0057EC:
    LDA [$38]             ; {22508}
    INC $38               ; {22510}
    INC $38               ; {22512}
    BRL cop_handler_006473.loc_0064C1 ; {22514}
}