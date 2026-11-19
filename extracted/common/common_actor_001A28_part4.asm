?BANK 00

?INCLUDE 'data_00F9F7'
?INCLUDE 'lib_014516'
?INCLUDE 'lib_014527'
?INCLUDE 'lib_shared_012769'

!player_level_bcd               1B6A
!player_exp                     1B78
!player_exp_next                1B7C
!player_level                   1B86
!player_hp                      1B88
!player_max_hp                  1B8A

---------------------------------------------

code_002F56 {
    LDA $player_level
    CMP #$0032
    BCC loc_002F61
    BRL loc_003002

  loc_002F61:
    ASL 
    ASL 
    TAY 
    LDA $&data_00F9F7.word_00FBB8, Y
    STA $1B7E
    LDA $&data_00F9F7.word_00FBB8+2, Y
    STA $player_exp_next
    COP [91]
    LDA $player_exp
    SEC 
    SBC $player_exp_next
    LDA $1B7A
    SBC $1B7E
    BCS loc_002F82
    RTL 

  loc_002F82:
    LDA $player_max_hp
    CLC 
    ADC #$0002
    CMP #$0065
    BCC loc_002F91
    LDA #$0064

  loc_002F91:
    STA $player_max_hp
    LDA $player_hp
    CLC 
    ADC #$0002
    CMP #$0065
    BCC loc_002FA3
    LDA #$0064

  loc_002FA3:
    STA $player_hp
    COP [37]
    INC $player_level
    SED 
    LDA $player_level_bcd
    CLC 
    ADC #$0001
    STA $player_level_bcd
    CLD 
    LSR 
    BCS loc_002FBF
    INC $1B72
    BRA loc_002FC2

  loc_002FBF:
    INC $1B76

  loc_002FC2:
    LDA #$001F
    TSB $0332
    LDA $player_level
    ASL 
    ASL 
    TAY 
    LDA $&data_00F9F7.word_00FBB8, Y
    STA $1B7E
    LDA $&data_00F9F7.word_00FBB8+2, Y
    STA $player_exp_next
    BRK #$97
    COP [03] ( #03 )
    PHX 
    LDY #$&lib_014516.asciistring_014516
    JSL $@lib_shared_012769.code_012769
    PLX 
    COP [1B] ( &code_002FEE, #$0014 )
}

code_002FEE {
    PHX 
    LDY #$&lib_014527.asciistring_014527
    JSL $@lib_shared_012769.code_012769
    PLX 
    COP [1B] ( &code_002FFD, #$000A )
}

code_002FFD {
    COP [04]
    BRL code_002F56

  loc_003002:
    COP [86]
    RTL 
}