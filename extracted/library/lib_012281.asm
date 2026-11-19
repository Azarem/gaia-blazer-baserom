?BANK 02

?INCLUDE 'lib_shared_01230B'
?INCLUDE 'lib_shared_012769'

!vram_upload_flags              03B8
!bg3_tilemap_buffer             7F7000

---------------------------------------------

code_012281 {
    STA $03C4             ; {74369}
    XBA                   ; {74372}
    PHA                   ; {74373}
    STZ $03C6             ; {74374}

  loc_012289:
    LDA #$2B              ; {74377}
    STA $7F6FC0, X        ; {74379}
    STA $bg3_tilemap_buffer, X ; {74383}
    LDA #$01              ; {74387}
    TSB $vram_upload_flags ; {74389}

  loc_012298:
    JSR $&lib_shared_012769.code_013169 ; {74392}
    BEQ loc_0122A2        ; {74395}
    JSR $&lib_shared_01230B.code_01230B ; {74397}
    BRA loc_012298        ; {74400}

  loc_0122A2:
    JSR $&lib_shared_012769.code_013169 ; {74402}
    BIT #$08              ; {74405}
    BNE loc_0122CE        ; {74407}
    BIT #$04              ; {74409}
    BNE loc_0122E3        ; {74411}
    BIT #$40              ; {74413}
    BNE loc_0122BF        ; {74415}
    BIT #$80              ; {74417}
    BNE loc_0122BA        ; {74419}
    JSR $&lib_shared_01230B.code_01230B ; {74421}
    BRA loc_0122A2        ; {74424}

  loc_0122BA:
    BRK #$18              ; {74426}
    CLC                   ; {74428}
    BRA loc_0122C2        ; {74429}

  loc_0122BF:
    BRK #$07              ; {74431}
    SEC                   ; {74433}

  loc_0122C2:
    LDA #$2B              ; {74434}
    STA $7F6FC0, X        ; {74436}
    STA $bg3_tilemap_buffer, X ; {74440}
    PLA                   ; {74444}
    RTL                   ; {74445}

  loc_0122CE:
    LDA $01, S            ; {74446}
    BEQ loc_012298        ; {74448}
    DEC                   ; {74450}
    STA $01, S            ; {74451}
    TXY                   ; {74453}
    REP #$20              ; {74454}
    TYA                   ; {74456}
    SEC                   ; {74457}
    SEC                   ; {74458}
    SBC #$0080            ; {74459}
    TAY                   ; {74462}
    SEP #$20              ; {74463}
    BRA loc_0122F8        ; {74465}

  loc_0122E3:
    LDA $01, S            ; {74467}
    INC                   ; {74469}
    CMP $03C4             ; {74470}
    BCS loc_012298        ; {74473}
    STA $01, S            ; {74475}
    TXY                   ; {74477}
    REP #$20              ; {74478}
    TYA                   ; {74480}
    CLC                   ; {74481}
    ADC #$0080            ; {74482}
    TAY                   ; {74485}
    SEP #$20              ; {74486}

  loc_0122F8:
    BRK #$07              ; {74488}
    LDA #$20              ; {74490}
    STA $7F6FC0, X        ; {74492}
    STA $bg3_tilemap_buffer, X ; {74496}
    STZ $03C6             ; {74500}
    TYX                   ; {74503}
    BRL loc_012289        ; {74504}
}