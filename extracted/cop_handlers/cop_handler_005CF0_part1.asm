?BANK 00

?INCLUDE 'common_shared_0FEEA6'
?INCLUDE 'data_00F9F7'
?INCLUDE 'engine_000000'
?INCLUDE 'lib_0118FC_part8'
?INCLUDE 'lib_shared_0131B7'

!APUIO0                         2140

---------------------------------------------

code_002C9B {
    SEP #$20
    LDA #$F1
    STA $APUIO0
    REP #$20
    COP [27] ( &code_002CA8 )
}

code_002CA8 {
    LDA $APUIO0
    AND #$00FF
    CMP #$00F1
    BEQ loc_002CB4
    RTL 

  loc_002CB4:
    SEP #$20
    LDA #$01
    STA $APUIO0
    REP #$20
    COP [27] ( &code_002CC1 )
}

code_002CC1 {
    SEP #$20
    LDA $APUIO0
    REP #$20
    BEQ code_002CCB
    RTL 
}
---------------------------------------------

code_002CCB {
    SEP #$20
    LDA #$F0
    STA $APUIO0
    REP #$20
    COP [27] ( &code_002CD8 )
}

code_002CD8 {
    SEP #$20
    LDA $APUIO0
    REP #$20
    BEQ loc_002CE2
    RTL 

  loc_002CE2:
    COP [1B] ( &code_002CE8, #$0002 )
}
---------------------------------------------

code_002CE8 {
    SEP #$20
    LDA #$FF
    STA $APUIO0
    REP #$20
    LDA $0030, X
    ASL 
    CLC 
    ADC $0030, X
    TAY 
    STZ $0030, X
    LDA $&data_00F9F7.table_00FB49, Y
    STA $29
    STA $0422
    SEP #$20
    LDA $&data_00F9F7.table_00FB49+2, Y
    STA $2B
    STA $0424
    REP #$20
    PHX 
    SEP #$20
    JSL $@lib_shared_0131B7.code_0131B7
    JSL $@lib_0118FC_part8.code_0131AE
    JSL $@common_shared_0FEEA6.code_0FEFF5
    JSL $@lib_shared_0131B7.code_0131B7
    JSL $@lib_0118FC_part8.code_0131A2
    REP #$20
    PLX 
    COP [1B] ( &code_002D31, #$0002 )
}

code_002D31 {
    SEP #$20
    LDA #$01
    STA $APUIO0
    REP #$20
    STZ $0458
    COP [86]
    RTL 

  loc_002D40:
    LDA $001A, X
    BIT #$1000
    BEQ loc_002D64
    LDA #$0258
    STA $0026, X
    COP [91]
    LDA $0016, X
    BIT #$8000
    BNE loc_002D59
    RTL 

  loc_002D59:
    DEC $0026, X
    BMI loc_002D5F
    RTL 

  loc_002D5F:
    JSL $@engine_000000.code_0013AB
    RTL 

  loc_002D64:
    COP [86]
    RTL 
}