?BANK 00

?INCLUDE 'engine_007A52'
?INCLUDE 'lib_014F02'
?INCLUDE 'lib_014F23'
?INCLUDE 'lib_014F43'
?INCLUDE 'lib_0270E4'

!L_choice_result                0003D0
!scene_next                     0318
!joy_block_mask                 0326
!warp_dest_x                    037C
!warp_dest_y                    037E

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
    COP [1A] ( &lib_014F43.asciistring_014F43, #02, &code_007754 )
    LDA $L_choice_result
    BNE loc_007699
    BRL code_0076EF

  loc_007699:
    BRL code_007754
}

code_00769C {
    COP [1A] ( &lib_014F23.asciistring_014F23, #03, &code_007754 )
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
    LDA $03BA
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
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_007754 )
    LDA $L_choice_result
    DEC 
    BEQ code_007754
    BRK #$66
    PHX 
    JSL $@lib_0270E4.code_0270E4
    PLX 
    LDA #$7FC0
    TSB $joy_block_mask
    COP [03] ( #3D )
    COP [04]
    LDA #$7FC0
    TRB $joy_block_mask
    COP [01] ( &asciistring_0077FA )
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_007754 )
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
    LDA $043F
    BEQ loc_00777B
    STZ $043F
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
    LDA $0372
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

asciistring_007825 |Rest well, there is [N]still much to be done-[JMP:&engine_007A52.asciistring_007A52]|

asciistring_007848 |[02:2][N]you are doing well- [N]Do not give up- [JMP:&engine_007A52.asciistring_007A52]|

asciistring_007866 |[08:448][END]|

asciistring_00786A |[10]A voice came from [N]above- [FIN]"Do not rush, but be [N]patient- You must [N]continue making steady[N]progress-ˮ [JMP:&engine_007A52.asciistring_007A52]|

asciistring_0078BB |[10]A voice came from [N]above- [FIN]"The Brown Stone you [N]received is one of 6 [N]stones in this world- [FIN]When all six of these [N]stones are gathered, [FIN]the gate leading to [N]the World of Evil [N]shall be opened- [FIN]Now, you must go to [N]GreenWood where the [N]next stone awaits [N]you-ˮ [JMP:&engine_007A52.asciistring_007A52]|