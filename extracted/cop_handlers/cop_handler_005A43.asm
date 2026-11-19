?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_012281'
?INCLUDE 'lib_shared_012769'

!vram_upload_flags              03B8
!choice_result                  03D0

---------------------------------------------

Cop1A_ChoiceMenu {
    TYX                   ; {23107}
    PHX                   ; {23108}
    LDA [$38]             ; {23109}
    INC $38               ; {23111}
    INC $38               ; {23113}
    TAY                   ; {23115}
    JSL $@lib_shared_012769.code_012769 ; {23116}
    SEP #$20              ; {23120}
    LDA #$00              ; {23122}
    XBA                   ; {23124}
    LDA [$38]             ; {23125}
    INC $38               ; {23127}
    BNE loc_005A5D        ; {23129}
    INC $39               ; {23131}

  loc_005A5D:
    JSL $@lib_012281.code_012281 ; {23133}
    PHA                   ; {23137}
    PHP                   ; {23138}
    LDX $03F7             ; {23139}
    JSL $@lib_shared_012769.code_012BDA ; {23142}
    LDA #$01              ; {23146}
    STA $vram_upload_flags ; {23148}
    PLP                   ; {23151}
    PLA                   ; {23152}
    REP #$20              ; {23153}
    PLX                   ; {23155}
    BCS loc_005A7F        ; {23156}
    AND #$00FF            ; {23158}
    STA $choice_result    ; {23161}
    BRL cop_handler_006473.loc_0064BB ; {23164}

  loc_005A7F:
    LDA [$38]             ; {23167}
    INC $38               ; {23169}
    INC $38               ; {23171}
    BRL cop_handler_006473.loc_0064C1 ; {23173}
}