?BANK 00

?INCLUDE 'lib_arithmetic'
?INCLUDE 'lib_save_system'
?INCLUDE 'shared_choice_prompt_texts'

!L_choice_result                0003D0
!scene_next                     0318
!joy_block_mask                 0326
!scene_sprite_attr              0372
!player_x                       0374
!player_y                       0376
!warp_dest_x                    037C
!warp_dest_y                    037E
!world_index                    03BA
!player_died                    043F

---------------------------------------------

code_0029E8 {
    COP [94]
    BRA code_0029E8
}
---------------------------------------------

code_002D67 {
    TYA 
    STA $001E, X
    STZ $0020, X
    COP [85] ( @code_002D96 )
    CPY #$06AA
    BEQ loc_002D93
    SEP #$20
    LDA #$00
    STA $0036, X
    REP #$20
    COP [91]

  loc_002D83:
    COP [82]
    LDA $0016, X
    BIT #$8000
    BEQ loc_002D83
    LDY $003E, X
    STA $0030, Y

  loc_002D93:
    COP [86]
    RTL 
}

code_002D96 {
    LDA $003C, X
    STA $0030, X
    LDA $player_x
    SEC 
    SBC $0000, X
    BMI loc_002DC4
    STA $16
    LDA $player_y
    SEC 
    SBC $0002, X
    BMI loc_002DB8
    STA $18
    CMP $16
    BCS loc_002E23
    BRA loc_002E11

  loc_002DB8:
    EOR #$FFFF
    INC 
    STA $18
    CMP $16
    BCS loc_002DEA
    BRA loc_002DFF

  loc_002DC4:
    EOR #$FFFF
    INC 
    STA $16
    LDA $player_y
    SEC 
    SBC $0002, X
    BMI loc_002DDB
    STA $18
    CMP $16
    BCS loc_002E35
    BRA loc_002E47

  loc_002DDB:
    EOR #$FFFF
    INC 
    STA $18
    CMP $16
    BCC loc_002DE8
    BRL loc_002E6B

  loc_002DE8:
    BRA loc_002E59

  loc_002DEA:
    JSR $&code_002E9C
    COP [91]
    DEC $0002, X
    DEC $0010, X
    BEQ loc_002DFA
    BRL loc_002E83

  loc_002DFA:
    INC $0000, X
    BRA loc_002E7D

  loc_002DFF:
    JSR $&code_002EA4
    COP [91]
    INC $0000, X
    DEC $0010, X
    BNE loc_002E83
    DEC $0002, X
    BRA loc_002E7D

  loc_002E11:
    JSR $&code_002EA4
    COP [91]
    INC $0000, X
    DEC $0010, X
    BNE loc_002E83
    INC $0002, X
    BRA loc_002E7D

  loc_002E23:
    JSR $&code_002E9C
    COP [91]
    INC $0002, X
    DEC $0010, X
    BNE loc_002E83
    INC $0000, X
    BRA loc_002E7D

  loc_002E35:
    JSR $&code_002E9C
    COP [91]
    INC $0002, X
    DEC $0010, X
    BNE loc_002E83
    DEC $0000, X
    BRA loc_002E7D

  loc_002E47:
    JSR $&code_002EA4
    COP [91]
    DEC $0000, X
    DEC $0010, X
    BNE loc_002E83
    INC $0002, X
    BRA loc_002E7D

  loc_002E59:
    JSR $&code_002EA4
    COP [91]
    DEC $0000, X
    DEC $0010, X
    BNE loc_002E83
    DEC $0002, X
    BRA loc_002E7D

  loc_002E6B:
    JSR $&code_002E9C
    COP [91]
    DEC $0002, X
    DEC $0010, X
    BNE loc_002E83
    DEC $0000, X
    BRA loc_002E7D

  loc_002E7D:
    LDA $0012, X
    STA $0010, X

  loc_002E83:
    LDA $003C, X
    CMP $0030, X
    BNE loc_002E99
    TAY 
    LDA $0000, X
    STA $0000, Y
    LDA $0002, X
    STA $0002, Y
    RTL 

  loc_002E99:
    COP [86]
    RTL 
}

code_002E9C {
    SEP #$20
    LDY $18
    LDA $16
    BRA loc_002EAA
}

code_002EA4 {
    SEP #$20
    LDY $16
    LDA $18

  loc_002EAA:
    BNE loc_002EAD
    INC 

  loc_002EAD:
    JSL $@lib_arithmetic.DivideWordByByte
    REP #$20
    AND #$00FF
    BNE loc_002EB9
    INC 

  loc_002EB9:
    STA $0010, X
    STA $0012, X
    RTS 
}
---------------------------------------------

code_00766C {
    COP [37]

  code_00766E:
    COP [91]
    COP [0D] ( #00, #07, #04, &code_00767F )
    COP [0D] ( #00, #07, #06, &code_007765 )
    RTL 
}

code_00767F {
    COP [01] ( &asciistring_0077B0 )
    COP [07] ( #$9B00, &code_00769C )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceRecordQuitText, #02, &code_007754 )
    LDA $L_choice_result
    BNE loc_007699
    BRL code_0076EF

  loc_007699:
    BRL code_007754
}

code_00769C {
    COP [1A] ( &shared_choice_prompt_texts.ChoiceRecordMoveQuitText, #03, &code_007754 )
    LDA $L_choice_result
    BNE loc_0076AC
    BRL code_0076EF

  loc_0076AC:
    DEC 
    BEQ loc_0076B2
    BRL code_007754

  loc_0076B2:
    COP [01] ( &asciistring_007866 )
    PHX 
    LDA #$0009
    STA $scene_next
    LDA $world_index
    ASL 
    ASL 
    TAX 
    LDA $@data_0076D3, X
    STA $warp_dest_x
    LDA $@data_0076D3+2, X
    STA $warp_dest_y
    PLX 
    RTL 
}
---------------------------------------------

data_0076D3 [
  unk4 < #$0070, #$00A0 >   ;00
  unk4 < #$0030, #$0160 >   ;01
  unk4 < #$00F0, #$0160 >   ;02
  unk4 < #$00F0, #$0060 >   ;03
  unk4 < #$01B0, #$0140 >   ;04
  unk4 < #$0170, #$0060 >   ;05
  unk4 < #$00F0, #$0020 >   ;06
]
---------------------------------------------

code_0076EF {
    COP [01] ( &asciistring_0077D4 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_007754 )
    LDA $L_choice_result
    DEC 
    BEQ code_007754
    BRK #$66
    PHX 
    JSL $@lib_save_system.SaveGameToSlot
    PLX 
    LDA #$7FC0
    TSB $joy_block_mask
    COP [03] ( #3D )
    COP [04]
    LDA #$7FC0
    TRB $joy_block_mask
    COP [01] ( &asciistring_0077FA )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_007754 )
    LDA $L_choice_result
    BEQ code_007754
    COP [01] ( &asciistring_007825 )
    LDA #$7F80
    TSB $joy_block_mask
    COP [03] ( #1F )
    COP [04]
    BRK #$8E
    COP [AC] ( @code_007798, #$0070, #$0050, #$0050 )
    COP [34]
    COP [03] ( #3D )
    COP [04]
    COP [31] ( #13 )
    COP [91]
    RTL 
}

code_007754 {
    COP [01] ( &asciistring_007848 )
    COP [91]
    COP [0D] ( #00, #07, #04, &code_007764 )
    BRL code_00766E
}

code_007764 {
    RTL 
}

code_007765 {
    LDA $player_died
    BEQ loc_00777B
    STZ $player_died
    COP [1B] ( &code_007773, #$0002 )
}

code_007773 {
    COP [01] ( &asciistring_00786A )
    COP [27] ( &code_00766E )

  loc_00777B:
    COP [07] ( #$8602, &code_007794 )
    COP [07] ( #$1B00, &code_007794 )
    COP [03] ( #03 )
    COP [04]
    COP [09] ( #$8602 )
    COP [01] ( &asciistring_0078BB )
}

code_007794 {
    COP [27] ( &code_00766E )
}

code_007798 {
    COP [A8] ( #$8000, #0E )
    LDA $scene_sprite_attr
    STA $001C, X
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #02 )
    COP [82]
    COP [86]
    RTL 
}

asciistring_0077B0 |[10]A voice came from [N]above- [FIN][JMP:&asciistring_0077C1+M]|

asciistring_0077C1 |[10][::][02:2], [N]how can I help you? [END]|

asciistring_0077D4 |I will record all [N]you have accomplished-[N]Is this okay? [END]|

asciistring_0077FA |Finished recording- [FIN]Do you wish to [N]continue? [END]|

asciistring_007825 |Rest well, there is [N]still much to be done-[JMP:&asciistring_007A52]|

asciistring_007848 |[02:2][N]you are doing well- [N]Do not give up- [JMP:&asciistring_007A52]|

asciistring_007866 |[08:448][END]|

asciistring_00786A |[10]A voice came from [N]above- [FIN]"Do not rush, but be [N]patient- You must [N]continue making steady[N]progress-ˮ [JMP:&asciistring_007A52]|

asciistring_0078BB |[10]A voice came from [N]above- [FIN]"The Brown Stone you [N]received is one of 6 [N]stones in this world- [FIN]When all six of these [N]stones are gathered, [FIN]the gate leading to [N]the World of Evil [N]shall be opened- [FIN]Now, you must go to [N]GreenWood where the [N]next stone awaits [N]you-ˮ [JMP:&asciistring_007A52]|
---------------------------------------------

asciistring_007A52 |[12][08:408][END]|