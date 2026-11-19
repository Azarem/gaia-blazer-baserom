?BANK 00

?INCLUDE 'common_shared_0FEEA6'
?INCLUDE 'data_00F9F7'
?INCLUDE 'engine_000000'
?INCLUDE 'lib_0118FC_part8'
?INCLUDE 'lib_shared_0131B7'

!APUIO0                         2140

---------------------------------------------

code_002C9B {
    SEP #$20              ; {11419}
    LDA #$F1              ; {11421}
    STA $APUIO0           ; {11423}
    REP #$20              ; {11426}
    COP [27] ( &code_002CA8 ) ; {11428}
}

code_002CA8 {
    LDA $APUIO0           ; {11432}
    AND #$00FF            ; {11435}
    CMP #$00F1            ; {11438}
    BEQ loc_002CB4        ; {11441}
    RTL                   ; {11443}

  loc_002CB4:
    SEP #$20              ; {11444}
    LDA #$01              ; {11446}
    STA $APUIO0           ; {11448}
    REP #$20              ; {11451}
    COP [27] ( &code_002CC1 ) ; {11453}
}

code_002CC1 {
    SEP #$20              ; {11457}
    LDA $APUIO0           ; {11459}
    REP #$20              ; {11462}
    BEQ code_002CCB       ; {11464}
    RTL                   ; {11466}
}
---------------------------------------------

code_002CCB {
    SEP #$20              ; {11467}
    LDA #$F0              ; {11469}
    STA $APUIO0           ; {11471}
    REP #$20              ; {11474}
    COP [27] ( &code_002CD8 ) ; {11476}
}

code_002CD8 {
    SEP #$20              ; {11480}
    LDA $APUIO0           ; {11482}
    REP #$20              ; {11485}
    BEQ loc_002CE2        ; {11487}
    RTL                   ; {11489}

  loc_002CE2:
    COP [1B] ( &code_002CE8, #$0002 ) ; {11490}
}
---------------------------------------------

code_002CE8 {
    SEP #$20              ; {11496}
    LDA #$FF              ; {11498}
    STA $APUIO0           ; {11500}
    REP #$20              ; {11503}
    LDA $0030, X          ; {11505}
    ASL                   ; {11508}
    CLC                   ; {11509}
    ADC $0030, X          ; {11510}
    TAY                   ; {11513}
    STZ $0030, X          ; {11514}
    LDA $&data_00F9F7.table_00FB49, Y ; {11517}
    STA $29               ; {11520}
    STA $0422             ; {11522}
    SEP #$20              ; {11525}
    LDA $&data_00F9F7.table_00FB49+2, Y ; {11527}
    STA $2B               ; {11530}
    STA $0424             ; {11532}
    REP #$20              ; {11535}
    PHX                   ; {11537}
    SEP #$20              ; {11538}
    JSL $@lib_shared_0131B7.code_0131B7 ; {11540}
    JSL $@lib_0118FC_part8.code_0131AE ; {11544}
    JSL $@common_shared_0FEEA6.code_0FEFF5 ; {11548}
    JSL $@lib_shared_0131B7.code_0131B7 ; {11552}
    JSL $@lib_0118FC_part8.code_0131A2 ; {11556}
    REP #$20              ; {11560}
    PLX                   ; {11562}
    COP [1B] ( &code_002D31, #$0002 ) ; {11563}
}

code_002D31 {
    SEP #$20              ; {11569}
    LDA #$01              ; {11571}
    STA $APUIO0           ; {11573}
    REP #$20              ; {11576}
    STZ $0458             ; {11578}
    COP [86]              ; {11581}
    RTL                   ; {11583}

  loc_002D40:
    LDA $001A, X          ; {11584}
    BIT #$1000            ; {11587}
    BEQ loc_002D64        ; {11590}
    LDA #$0258            ; {11592}
    STA $0026, X          ; {11595}
    COP [91]              ; {11598}
    LDA $0016, X          ; {11600}
    BIT #$8000            ; {11603}
    BNE loc_002D59        ; {11606}
    RTL                   ; {11608}

  loc_002D59:
    DEC $0026, X          ; {11609}
    BMI loc_002D5F        ; {11612}
    RTL                   ; {11614}

  loc_002D5F:
    JSL $@engine_000000.code_0013AB ; {11615}
    RTL                   ; {11619}

  loc_002D64:
    COP [86]              ; {11620}
    RTL                   ; {11622}
}