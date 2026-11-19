?BANK 03

?INCLUDE 'data_00F9F7'

!frame_counter                  0312
!joy_pressed                    0322
!joy_block_mask                 0326
!player_actor                   039C

---------------------------------------------

code_01AF5C {
    COP [A4]              ; {110428}
    COP [05] ( #$0404 )   ; {110430}
    LDY $player_actor     ; {110434}
    LDA $0000, Y          ; {110437}
    CMP #$04B0            ; {110440}
    BCC code_01AF75       ; {110443}
    COP [A0] ( #$FFB0 )   ; {110445}
    COP [27] ( &code_01AF97 ) ; {110449}

  code_01AF75:
    COP [91]              ; {110453}
    COP [0D] ( #00, #47, #38, &code_01AF7F ) ; {110455}
    RTL                   ; {110462}
}

code_01AF7F {
    LDA $joy_pressed      ; {110463}
    AND #$0800            ; {110466}
    BNE loc_01AF88        ; {110469}
    RTL                   ; {110471}

  loc_01AF88:
    COP [85] ( @code_01AFB9 ) ; {110472}
    COP [81] ( #2B, #14 ) ; {110477}
    COP [83]              ; {110481}
    COP [27] ( &code_01AF97 ) ; {110483}
}

code_01AF97 {
    COP [91]              ; {110487}
    COP [0D] ( #00, #47, #33, &code_01AFA1 ) ; {110489}
    RTL                   ; {110496}
}

code_01AFA1 {
    LDA $joy_pressed      ; {110497}
    AND #$0400            ; {110500}
    BNE loc_01AFAA        ; {110503}
    RTL                   ; {110505}

  loc_01AFAA:
    COP [85] ( @code_01AFB9 ) ; {110506}
    COP [81] ( #2D, #14 ) ; {110511}
    COP [83]              ; {110515}
    COP [27] ( &code_01AF75 ) ; {110517}
}

code_01AFB9 {
    LDA #$2F80            ; {110521}
    TSB $joy_block_mask   ; {110524}
    COP [03] ( #51 )      ; {110527}
    LDY $003C, X          ; {110530}
    LDA $0002, Y          ; {110533}
    LDY $player_actor     ; {110536}
    STA $0002, Y          ; {110539}
    LDY $039E             ; {110542}
    STA $0002, Y          ; {110545}
    PHX                   ; {110548}
    LDX $player_actor     ; {110549}
    LDA $001E, X          ; {110552}
    ASL                   ; {110555}
    TAX                   ; {110556}
    LDA $&data_00F9F7.word_00FAD7, X ; {110557}
    CLC                   ; {110560}
    ADC $0002, Y          ; {110561}
    STA $0002, Y          ; {110564}
    PLX                   ; {110567}
    LDA $frame_counter    ; {110568}
    AND #$0003            ; {110571}
    BNE loc_01AFF2        ; {110574}
    BRK #$63              ; {110576}

  loc_01AFF2:
    COP [04]              ; {110578}
    LDA #$2F80            ; {110580}
    TRB $joy_block_mask   ; {110583}
    COP [86]              ; {110586}
    RTL                   ; {110588}
}