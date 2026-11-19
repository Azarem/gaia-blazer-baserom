?BANK 00

?INCLUDE 'data_00BA0D'
?INCLUDE 'engine_000000'
?INCLUDE 'engine_0029EC'
?INCLUDE 'lib_0108BB'
?INCLUDE 'lib_027348'
?INCLUDE 'lib_0273A2'
?INCLUDE 'meta_tables_008000'

!joy_block_mask                 0326
!player_actor                   039C
!actor_list_tail                06A6
!player_hp                      1B88
!player_max_hp                  1B8A
!vram_write_queue               1C7B

---------------------------------------------

code_003005 {
    PHP                   ; {12293}
    REP #$20              ; {12294}
    LDX $player_actor     ; {12296}
    LDA $0016, X          ; {12299}
    BIT #$0400            ; {12302}
    BNE loc_00305D        ; {12305}
    LDA $player_hp        ; {12307}
    ORA $043B             ; {12310}
    BNE loc_00305D        ; {12313}
    COP [19] ( #38, &code_00302B ) ; {12315}
    LDA $player_max_hp    ; {12320}
    STA $043B             ; {12323}
    COP [0B] ( #38 )      ; {12326}
    BRA loc_00305D        ; {12329}
}

code_00302B {
    COP [19] ( #39, &code_003035 ) ; {12331}
    COP [0B] ( #39 )      ; {12336}
    BRA loc_003042        ; {12339}
}

code_003035 {
    COP [19] ( #40, &code_00303C ) ; {12341}
    BRA loc_003042        ; {12346}
}

code_00303C {
    STZ $1B66             ; {12348}
    STZ $1B68             ; {12351}

  loc_003042:
    LDA $0016, X          ; {12354}
    AND #$F7FF            ; {12357}
    STA $0016, X          ; {12360}
    LDA $0016, X          ; {12363}
    ORA #$0400            ; {12366}
    STA $0016, X          ; {12369}
    LDA #$2080            ; {12372}
    STA $joy_block_mask   ; {12375}
    INC $043F             ; {12378}

  loc_00305D:
    PLP                   ; {12381}
    RTL                   ; {12382}
}
---------------------------------------------

code_00305F {
    SEP #$20              ; {12383}
    LDA #$00              ; {12385}
    STA $0036, X          ; {12387}
    REP #$20              ; {12390}
    LDA $0016, X          ; {12392}
    AND #$DFF7            ; {12395}
    STA $0016, X          ; {12398}
    COP [A8] ( #$8000, #0E ) ; {12401}
    LDA $001C, X          ; {12406}
    STA $0032, X          ; {12409}
    AND #$FEFF            ; {12412}
    STA $001C, X          ; {12415}
    COP [15]              ; {12418}

  loc_003084:
    COP [80] ( #0D )      ; {12420}
    COP [82]              ; {12423}
    LDA $0034, X          ; {12425}
    ASL                   ; {12428}
    ASL                   ; {12429}
    ASL                   ; {12430}
    ASL                   ; {12431}
    ASL                   ; {12432}
    TAY                   ; {12433}
    LDA $&data_00BA0D+1E, Y ; {12434}
    LDY #$1ADE            ; {12437}
    JSL $@lib_0273A2.code_0273A2 ; {12440}
    BCC loc_003084        ; {12444}
    COP [16]              ; {12446}
    LDA $0034, X          ; {12448}
    LDY #$1A9E            ; {12451}
    JSL $@lib_027348.code_027348 ; {12454}
    LDY #$1ADE            ; {12458}
    JSL $@lib_027348.code_027348 ; {12461}
    PHX                   ; {12465}
    TAX                   ; {12466}
    LDA $7F0203, X        ; {12467}
    AND #$FFBF            ; {12471}
    STA $7F0203, X        ; {12474}
    PLX                   ; {12478}
    COP [A8] ( #$3800, #7E ) ; {12479}
    LDA $0032, X          ; {12484}
    STA $001C, X          ; {12487}
    LDY $0038, X          ; {12490}
    SEP #$20              ; {12493}
    LDA $&meta_tables_008000+5, Y ; {12495}
    STA $001E, X          ; {12498}
    LDA $&meta_tables_008000+A, Y ; {12501}
    STA $0024, X          ; {12504}
    LDA $&meta_tables_008000+D, Y ; {12507}
    STA $0036, X          ; {12510}
    REP #$20              ; {12513}
    LDA $&meta_tables_008000+6, Y ; {12515}
    ORA #$8000            ; {12518}
    AND #$DFFF            ; {12521}
    STA $0016, X          ; {12524}
    LDA $&meta_tables_008000+8, Y ; {12527}
    STA $0022, X          ; {12530}
    LDA $&meta_tables_008000+B, Y ; {12533}
    STA $0018, X          ; {12536}
    STZ $0030, X          ; {12539}
    STZ $0020, X          ; {12542}
    JSL $@engine_000000.code_0008F3 ; {12545}
    STZ $0014, X          ; {12549}
    STZ $0004, X          ; {12552}
    STZ $0006, X          ; {12555}
    RTL                   ; {12558}
}

code_00310F {
    PHX                   ; {12559}
    LDX $03A0             ; {12560}
    LDA $0000, X          ; {12563}
    SEC                   ; {12566}
    SBC #$0030            ; {12567}
    BPL loc_00311F        ; {12570}
    LDA #$0000            ; {12572}

  loc_00311F:
    STA $16               ; {12575}
    LDA $0000, X          ; {12577}
    CLC                   ; {12580}
    ADC #$0030            ; {12581}
    SEC                   ; {12584}
    SBC $16               ; {12585}
    STA $1A               ; {12587}
    BMI loc_003186        ; {12589}
    LDA $0002, X          ; {12591}
    SEC                   ; {12594}
    SBC #$0030            ; {12595}
    BPL loc_00313B        ; {12598}
    LDA #$0000            ; {12600}

  loc_00313B:
    STA $18               ; {12603}
    LDA $0002, X          ; {12605}
    CLC                   ; {12608}
    ADC #$0030            ; {12609}
    SEC                   ; {12612}
    SBC $18               ; {12613}
    STA $1C               ; {12615}
    BMI loc_003186        ; {12617}
    LDA $actor_list_tail  ; {12619}
    BRA loc_003153        ; {12622}

  loc_003150:
    LDA $003E, X          ; {12624}

  loc_003153:
    TAX                   ; {12627}
    BEQ loc_003186        ; {12628}
    LDA $0016, X          ; {12630}
    CMP #$0301            ; {12633}
    BNE loc_003150        ; {12636}
    LDA $0000, X          ; {12638}
    SEC                   ; {12641}
    SBC $16               ; {12642}
    CMP $1A               ; {12644}
    BCS loc_003150        ; {12646}
    LDA $0002, X          ; {12648}
    SEC                   ; {12651}
    SBC $18               ; {12652}
    CMP $1C               ; {12654}
    BCS loc_003150        ; {12656}
    SEP #$20              ; {12658}
    LDA #$^engine_0029EC.code_0029EC ; {12660}
    STA $0036, X          ; {12662}
    REP #$20              ; {12665}
    LDA #$&engine_0029EC.code_0029EC ; {12667}
    STA $0018, X          ; {12670}
    STZ $0014, X          ; {12673}
    BRA loc_003150        ; {12676}

  loc_003186:
    PLX                   ; {12678}
    RTL                   ; {12679}
}

code_003188 {
    LDA #$FFFF            ; {12680}
    STA $joy_block_mask   ; {12683}
    COP [1B] ( &code_003194, #$0001 ) ; {12686}
}

code_003194 {
    LDA $vram_write_queue ; {12692}
    BEQ loc_00319A        ; {12695}
    RTL                   ; {12697}

  loc_00319A:
    BRK #$83              ; {12698}
    LDA $0030, X          ; {12700}
    JSL $@lib_0108BB.code_0108BB ; {12703}
    COP [27] ( &code_0031A7 ) ; {12707}
}

code_0031A7 {
    STZ $joy_block_mask   ; {12711}
    COP [86]              ; {12714}
    RTL                   ; {12716}
}