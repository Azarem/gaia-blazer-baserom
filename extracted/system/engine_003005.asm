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
    PHP 
    REP #$20
    LDX $player_actor
    LDA $0016, X
    BIT #$0400
    BNE loc_00305D
    LDA $player_hp
    ORA $043B
    BNE loc_00305D
    COP [19] ( #38, &code_00302B )
    LDA $player_max_hp
    STA $043B
    COP [0B] ( #38 )
    BRA loc_00305D
}

code_00302B {
    COP [19] ( #39, &code_003035 )
    COP [0B] ( #39 )
    BRA loc_003042
}

code_003035 {
    COP [19] ( #40, &code_00303C )
    BRA loc_003042
}

code_00303C {
    STZ $1B66
    STZ $1B68

  loc_003042:
    LDA $0016, X
    AND #$F7FF
    STA $0016, X
    LDA $0016, X
    ORA #$0400
    STA $0016, X
    LDA #$2080
    STA $joy_block_mask
    INC $043F

  loc_00305D:
    PLP 
    RTL 
}
---------------------------------------------

code_00305F {
    SEP #$20
    LDA #$00
    STA $0036, X
    REP #$20
    LDA $0016, X
    AND #$DFF7
    STA $0016, X
    COP [A8] ( #$8000, #0E )
    LDA $001C, X
    STA $0032, X
    AND #$FEFF
    STA $001C, X
    COP [15]

  loc_003084:
    COP [80] ( #0D )
    COP [82]
    LDA $0034, X
    ASL 
    ASL 
    ASL 
    ASL 
    ASL 
    TAY 
    LDA $&data_00BA0D+1E, Y
    LDY #$1ADE
    JSL $@lib_0273A2.code_0273A2
    BCC loc_003084
    COP [16]
    LDA $0034, X
    LDY #$1A9E
    JSL $@lib_027348.code_027348
    LDY #$1ADE
    JSL $@lib_027348.code_027348
    PHX 
    TAX 
    LDA $7F0203, X
    AND #$FFBF
    STA $7F0203, X
    PLX 
    COP [A8] ( #$3800, #7E )
    LDA $0032, X
    STA $001C, X
    LDY $0038, X
    SEP #$20
    LDA $&meta_tables_008000+5, Y
    STA $001E, X
    LDA $&meta_tables_008000+A, Y
    STA $0024, X
    LDA $&meta_tables_008000+D, Y
    STA $0036, X
    REP #$20
    LDA $&meta_tables_008000+6, Y
    ORA #$8000
    AND #$DFFF
    STA $0016, X
    LDA $&meta_tables_008000+8, Y
    STA $0022, X
    LDA $&meta_tables_008000+B, Y
    STA $0018, X
    STZ $0030, X
    STZ $0020, X
    JSL $@engine_000000.code_0008F3
    STZ $0014, X
    STZ $0004, X
    STZ $0006, X
    RTL 
}

code_00310F {
    PHX 
    LDX $03A0
    LDA $0000, X
    SEC 
    SBC #$0030
    BPL loc_00311F
    LDA #$0000

  loc_00311F:
    STA $16
    LDA $0000, X
    CLC 
    ADC #$0030
    SEC 
    SBC $16
    STA $1A
    BMI loc_003186
    LDA $0002, X
    SEC 
    SBC #$0030
    BPL loc_00313B
    LDA #$0000

  loc_00313B:
    STA $18
    LDA $0002, X
    CLC 
    ADC #$0030
    SEC 
    SBC $18
    STA $1C
    BMI loc_003186
    LDA $actor_list_tail
    BRA loc_003153

  loc_003150:
    LDA $003E, X

  loc_003153:
    TAX 
    BEQ loc_003186
    LDA $0016, X
    CMP #$0301
    BNE loc_003150
    LDA $0000, X
    SEC 
    SBC $16
    CMP $1A
    BCS loc_003150
    LDA $0002, X
    SEC 
    SBC $18
    CMP $1C
    BCS loc_003150
    SEP #$20
    LDA #$^engine_0029EC.code_0029EC
    STA $0036, X
    REP #$20
    LDA #$&engine_0029EC.code_0029EC
    STA $0018, X
    STZ $0014, X
    BRA loc_003150

  loc_003186:
    PLX 
    RTL 
}

code_003188 {
    LDA #$FFFF
    STA $joy_block_mask
    COP [1B] ( &code_003194, #$0001 )
}

code_003194 {
    LDA $vram_write_queue
    BEQ loc_00319A
    RTL 

  loc_00319A:
    BRK #$83
    LDA $0030, X
    JSL $@lib_0108BB.code_0108BB
    COP [27] ( &code_0031A7 )
}

code_0031A7 {
    STZ $joy_block_mask
    COP [86]
    RTL 
}