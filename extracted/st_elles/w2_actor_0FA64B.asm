?BANK 1F

?INCLUDE 'engine_000000'

!frame_counter                  0312
!player_x                       0374
!player_y                       0376

---------------------------------------------

code_0FA64B {
    COP [91]              ; {1025611}
    COP [07] ( #$8903, &code_0FA6A6 ) ; {1025613}
    COP [19] ( #0B, &code_0FA697 ) ; {1025619}
    COP [B0] ( @code_0FA6A9, #$0310 ) ; {1025624}
    COP [91]              ; {1025631}
    COP [19] ( #0B, &code_0FA68A ) ; {1025633}
    LDY $003E, X          ; {1025638}
    LDA $player_x         ; {1025641}
    STA $0000, Y          ; {1025644}
    LDA $player_y         ; {1025647}
    SEC                   ; {1025650}
    SBC #$0004            ; {1025651}
    STA $0002, Y          ; {1025654}
    LDA $frame_counter    ; {1025657}
    AND #$00FF            ; {1025660}
    BEQ loc_0FA682        ; {1025663}
    RTL                   ; {1025665}

  loc_0FA682:
    COP [AF] ( @code_0FA6CB, #$2040 ) ; {1025666}
    RTL                   ; {1025673}
}

code_0FA68A {
    LDY $003E, X          ; {1025674}
    LDA #$0000            ; {1025677}
    STA $0014, Y          ; {1025680}
    COP [27] ( &code_0FA64B ) ; {1025683}
}

code_0FA697 {
    LDA $frame_counter    ; {1025687}
    AND #$003F            ; {1025690}
    BNE loc_0FA6A2        ; {1025693}
    COP [39] ( #01 )      ; {1025695}

  loc_0FA6A2:
    COP [27] ( &code_0FA64B ) ; {1025698}
}

code_0FA6A6 {
    COP [91]              ; {1025702}
    RTL                   ; {1025704}
}

code_0FA6A9 {
    COP [A3]              ; {1025705}
    COP [A2] ( #30 )      ; {1025707}
    LDA #$0024            ; {1025710}
    STA $001E, X          ; {1025713}
    STZ $0020, X          ; {1025716}
    JSL $@engine_000000.code_0008F3 ; {1025719}
    COP [A3]              ; {1025723}
    COP [91]              ; {1025725}

  loc_0FA6BF:
    COP [19] ( #0B, &code_0FA6C8 ) ; {1025727}
    COP [82]              ; {1025732}
    BRA loc_0FA6BF        ; {1025734}
}

code_0FA6C8 {
    COP [86]              ; {1025736}
    RTL                   ; {1025738}
}

code_0FA6CB {
    COP [A3]              ; {1025739}
    COP [A2] ( #30 )      ; {1025741}
    LDA $player_x         ; {1025744}
    CLC                   ; {1025747}
    ADC #$0004            ; {1025748}
    STA $0000, X          ; {1025751}
    LDA $player_y         ; {1025754}
    SEC                   ; {1025757}
    SBC #$0010            ; {1025758}
    STA $0002, X          ; {1025761}
    LDA $0016, X          ; {1025764}
    AND #$DFFF            ; {1025767}
    STA $0016, X          ; {1025770}
    COP [80] ( #22 )      ; {1025773}
    COP [82]              ; {1025776}
    COP [86]              ; {1025778}
    RTL                   ; {1025780}
}