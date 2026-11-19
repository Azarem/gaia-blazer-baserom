?BANK 04

?INCLUDE 'lib_0118FC_part10'
?INCLUDE 'lib_014536'
?INCLUDE 'lib_014547'
?INCLUDE 'lib_01456A'
?INCLUDE 'lib_shared_012769'
?INCLUDE 'lib_shared_0131B7'

!frame_counter                  0312
!vram_upload_flags              03B8
!APUIO0                         2140
!JOY1L                          4218

---------------------------------------------

code_027572 {
    LDA $03A2             ; {161138}
    BMI loc_0275DB        ; {161141}
    BNE loc_0275D1        ; {161143}
    LDA $0323             ; {161145}
    BIT #$10              ; {161148}
    BEQ loc_0275DB        ; {161150}
    INC $03A2             ; {161152}
    LDA #$F2              ; {161155}
    STA $APUIO0           ; {161157}
    LDA $JOY1L            ; {161160}
    BIT #$80              ; {161163}
    BNE loc_0275B1        ; {161165}
    LDY #$&lib_014536.asciistring_014536 ; {161167}
    JSL $@lib_shared_012769.code_012769 ; {161170}
    LDA $0439             ; {161174}
    BNE loc_0275AC        ; {161177}
    LDA $0456             ; {161179}
    LDX #$1B80            ; {161182}
    JSL $@lib_0118FC_part10.code_013215 ; {161185}
    LDY #$&lib_014547.asciistring_014547 ; {161189}
    JSL $@lib_shared_012769.code_012769 ; {161192}

  loc_0275AC:
    LDA #$01              ; {161196}
    STA $vram_upload_flags ; {161198}

  loc_0275B1:
    JSR $&code_0275DC     ; {161201}
    BNE loc_0275B1        ; {161204}

  loc_0275B6:
    JSR $&code_0275DC     ; {161206}
    BEQ loc_0275B6        ; {161209}
    LDY #$&lib_01456A.asciistring_01456A ; {161211}
    JSL $@lib_shared_012769.code_012769 ; {161214}
    LDA #$01              ; {161218}
    STA $vram_upload_flags ; {161220}
    LDA #$01              ; {161223}
    STA $APUIO0           ; {161225}
    JSL $@lib_shared_0131B7.code_0131B7 ; {161228}
    RTL                   ; {161232}

  loc_0275D1:
    LDA $0323             ; {161233}
    BIT #$10              ; {161236}
    BNE loc_0275DB        ; {161238}
    STZ $03A2             ; {161240}

  loc_0275DB:
    RTL                   ; {161243}
}

code_0275DC {
    LDX $frame_counter    ; {161244}
    DEX                   ; {161247}
    STX $frame_counter    ; {161248}
    JSL $@lib_shared_0131B7.code_0131B7 ; {161251}
    LDA $0323             ; {161255}
    BIT #$10              ; {161258}
    RTS                   ; {161260}
}