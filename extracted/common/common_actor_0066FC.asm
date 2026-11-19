?BANK 00

?INCLUDE 'engine_006B7F'
?INCLUDE 'lib_01186E'
?INCLUDE 'lib_013B27'
?INCLUDE 'lib_013B36'
?INCLUDE 'lib_013B85'
?INCLUDE 'lib_013BE1'
?INCLUDE 'lib_013C3D'
?INCLUDE 'lib_013CB6'
?INCLUDE 'lib_013D4D'
?INCLUDE 'lib_013DBA'
?INCLUDE 'lib_013E2A'
?INCLUDE 'lib_013E51'
?INCLUDE 'lib_013EBF'
?INCLUDE 'lib_013F35'
?INCLUDE 'lib_013FCD'
?INCLUDE 'lib_014023'
?INCLUDE 'lib_01406A'
?INCLUDE 'lib_0140FA'
?INCLUDE 'lib_027781_part2'
?INCLUDE 'lib_shared_012769'

!joy_pressed                    0322
!joy_block_mask                 0326
!player_actor                   039C
!BGMODE                         2105
!TM                             212C
!coldata_buffer                 7F0200

---------------------------------------------

code_0066FC {
    LDA #$3000
    TSB $joy_block_mask
    STZ $joy_pressed
    STX $player_actor
    LDA $0445
    BEQ loc_006710
    BRL engine_006B7F.loc_006CC1

  loc_006710:
    COP [85] ( @code_006B61 )

  code_006715:
    STZ $0482
    SEP #$20
    LDA #$E0
    STA $coldata_buffer
    LDA #$0F
    STA $BGMODE
    LDA #$11
    STA $TM
    REP #$20
    LDA #$FFC8
    STA $046A
    LDA #$003E
    STA $046C
    LDA #$0083
    STA $0480
    COP [91]
    INC $046A
    LDA $046A
    CMP #$013E
    BEQ loc_00674C
    RTL 

  loc_00674C:
    LDA #$0002
    STA $0480
    COP [03] ( #1F )
    COP [04]
    LDA #$0080
    STA $046A
    COP [91]
    LDA $0480
    CLC 
    ADC #$0004
    STA $0480
    CMP #$0206
    BEQ loc_00676F
    RTL 

  loc_00676F:
    COP [03] ( #1F )
    COP [04]
    PHX 
    LDY #$&lib_013B36.asciistring_013B36
    JSL $@lib_shared_012769.code_012769
    PLX 
    COP [85] ( @code_006A5E )
    COP [03] ( #1F )
    COP [04]
    COP [AC] ( @code_006B51, #$FF50, #$0080, #$2300 )
    COP [AC] ( @code_006B29, #$0198, #$0078, #$0300 )
    COP [AC] ( @code_006B01, #$0198, #$0078, #$0300 )
    COP [85] ( @code_006A90 )
    COP [03] ( #F1 )
    COP [04]
    PHX 
    LDY #$&lib_013B27.asciistring_013B27
    JSL $@lib_shared_012769.code_012769
    PLX 
    LDA #$3000
    TRB $joy_block_mask
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #79 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #3D )
    COP [04]
    INC $0482
    COP [03] ( #79 )
    COP [04]
    PHX 
    JSL $@lib_027781_part2.code_0276EE
    LDY #$&lib_013B85.asciistring_013B85
    JSL $@lib_shared_012769.code_012769
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_027781_part2.code_0276EE
    LDY #$&lib_013BE1.asciistring_013BE1
    JSL $@lib_shared_012769.code_012769
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_027781_part2.code_0276EE
    LDY #$&lib_013C3D.asciistring_013C3D
    JSL $@lib_shared_012769.code_012769
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_027781_part2.code_0276EE
    LDY #$&lib_013CB6.asciistring_013CB6
    JSL $@lib_shared_012769.code_012769
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_027781_part2.code_0276EE
    LDY #$&lib_013D4D.asciistring_013D4D
    JSL $@lib_shared_012769.code_012769
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_027781_part2.code_0276EE
    LDY #$&lib_013DBA.asciistring_013DBA
    JSL $@lib_shared_012769.code_012769
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_027781_part2.code_0276EE
    LDY #$&lib_013E2A.asciistring_013E2A
    JSL $@lib_shared_012769.code_012769
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_027781_part2.code_0276EE
    LDY #$&lib_013E51.asciistring_013E51
    JSL $@lib_shared_012769.code_012769
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_027781_part2.code_0276EE
    LDY #$&lib_013EBF.asciistring_013EBF
    JSL $@lib_shared_012769.code_012769
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_027781_part2.code_0276EE
    LDY #$&lib_013F35.asciistring_013F35
    JSL $@lib_shared_012769.code_012769
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_027781_part2.code_0276EE
    LDY #$&lib_013FCD.asciistring_013FCD
    JSL $@lib_shared_012769.code_012769
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_027781_part2.code_0276EE
    LDY #$&lib_014023.asciistring_014023
    JSL $@lib_shared_012769.code_012769
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_027781_part2.code_0276EE
    LDY #$&lib_01406A.asciistring_01406A
    JSL $@lib_shared_012769.code_012769
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    PHX 
    JSL $@lib_027781_part2.code_0276EE
    LDY #$&lib_0140FA.asciistring_0140FA
    JSL $@lib_shared_012769.code_012769
    PLX 
    COP [85] ( @code_006A40 )
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [85] ( @code_006A25 )
    COP [03] ( #21 )
    COP [04]
    JSL $@lib_027781_part2.code_0276EE
    COP [03] ( #1F )
    COP [04]
    STZ $0482
    COP [03] ( #81 )
    COP [04]
    LDA #$FFFF
    STA $0482
    LDA #$FFC8
    STA $046A
    LDA #$003E
    STA $046C
    LDA #$0083
    STA $0480
    COP [1B] ( &code_006715, #$0001 )
}

code_006A25 {
    STZ $0030, X
    COP [03] ( #20 )
    SEP #$20
    LDA $0030, X
    ORA #$E0
    STA $coldata_buffer
    REP #$20
    INC $0030, X
    COP [04]
    COP [86]
    RTL 
}

code_006A40 {
    LDA #$001F
    STA $0030, X
    COP [03] ( #20 )
    SEP #$20
    LDA $0030, X
    ORA #$E0
    STA $coldata_buffer
    REP #$20
    DEC $0030, X
    COP [04]
    COP [86]
    RTL 
}

code_006A5E {
    SEP #$20
    LDA #$05
    XBA 
    LDA #$^binary_006A86
    LDY #$&binary_006A86
    JSL $@lib_01186E.code_01188A
    LDA #$2C
    XBA 
    LDA #$^binary_006A8B
    LDY #$&binary_006A8B
    JSL $@lib_01186E.code_01188A
    REP #$20
    LDA $0482
    BNE loc_006A80
    RTL 

  loc_006A80:
    STZ $0042
    COP [86]
    RTL 
}
---------------------------------------------

binary_006A86 #7F0F600900
---------------------------------------------

binary_006A8B #7F11601400
---------------------------------------------

code_006A90 {
    COP [03] ( #80 )
    LDY $003E, X
    LDA $0000, Y
    DEC 
    DEC 
    STA $0000, Y
    LDA $003E, Y
    TAY 
    LDA $0000, Y
    DEC 
    DEC 
    STA $0000, Y
    LDA $003E, Y
    TAY 
    LDA $0000, Y
    INC 
    INC 
    STA $0000, Y
    COP [04]
    COP [91]
    LDA $0482
    BNE loc_006AC0
    RTL 

  loc_006AC0:
    COP [03] ( #40 )
    LDY $003E, X
    LDA $0002, Y
    DEC 
    STA $0002, Y
    LDA $003E, Y
    TAY 
    LDA $0002, Y
    DEC 
    STA $0002, Y
    COP [04]
    COP [91]
    LDA $0482
    BEQ loc_006AE2
    RTL 

  loc_006AE2:
    COP [03] ( #80 )
    LDY $003E, X
    LDA $0000, Y
    DEC 
    DEC 
    STA $0000, Y
    LDA $003E, Y
    TAY 
    LDA $0000, Y
    DEC 
    DEC 
    STA $0000, Y
    COP [04]
    COP [86]
    RTL 
}

code_006B01 {
    COP [80] ( #00 )
    COP [82]
    COP [91]
    LDA $0482
    BMI loc_006B26
    LDA $0000, X
    CMP #$0098
    BEQ loc_006B16
    RTL 

  loc_006B16:
    COP [80] ( #03 )
    COP [82]
    COP [80] ( #00 )
    COP [82]
    COP [1B] ( &code_006B01, #$012C )

  loc_006B26:
    COP [86]
    RTL 
}

code_006B29 {
    COP [80] ( #01 )
    COP [82]
    COP [91]
    LDA $0482
    BMI loc_006B4E
    LDA $0000, X
    CMP #$0098
    BEQ loc_006B3E
    RTL 

  loc_006B3E:
    COP [80] ( #04 )
    COP [82]
    COP [80] ( #01 )
    COP [82]
    COP [1B] ( &code_006B29, #$012C )

  loc_006B4E:
    COP [86]
    RTL 
}

code_006B51 {
    COP [80] ( #02 )
    COP [82]
    COP [91]
    LDA $0482
    BNE loc_006B5E
    RTL 

  loc_006B5E:
    COP [86]
    RTL 
}

code_006B61 {
    LDA $joy_pressed
    BIT #$1000
    BNE loc_006B6A
    RTL 

  loc_006B6A:
    COP [10] ( #$0A00, #01, #$0000, #$0000 )
    LDA #$0001
    STA $031E
    STA $0445
    COP [86]
    RTL 
}