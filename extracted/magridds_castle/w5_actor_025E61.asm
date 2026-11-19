?BANK 04

?INCLUDE 'engine_000000'
?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_actor_025E61_part2'
?INCLUDE 'w5_shared_02706C'

!joy_block_mask                 0326
!player_actor                   039C

---------------------------------------------

code_025E61 {
    COP [14] ( #$0183, &code_025E68 )
    RTL 
}

code_025E68 {
    COP [30] ( #$0183, &code_02601D, #04 )
    COP [07] ( #$9F05, &code_025FDC )
    COP [07] ( #$8805, &code_025FAF )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [15]
    COP [14] ( #$016E, &code_025E8B )
    BRL loc_025E91
}

code_025E8B {
    COP [14] ( #$0181, &code_025E98 )

  loc_025E91:
    COP [17] ( &code_025FDF )
    COP [91]
    RTL 
}

code_025E98 {
    COP [17] ( &code_025FE4 )
    COP [05] ( #$0001 )
    COP [96]
    COP [80] ( #23 )
    COP [82]
    PHX 
    LDX $player_actor
    LDA #$0003
    STA $001E, X
    STZ $0020, X
    JSL $@engine_000000.code_0008F3
    PLX 
    COP [05] ( #$0005 )
    COP [16]
    COP [81] ( #26, #02 )
    COP [83]
    COP [80] ( #23 )
    COP [82]
    COP [15]
    COP [01] ( &w5_actor_025E61_part2.asciistring_026240 )
    COP [03] ( #1F )
    COP [04]
    COP [01] ( &w5_actor_025E61_part2.asciistring_02626D )
    COP [03] ( #3D )
    COP [04]
    COP [01] ( &w5_actor_025E61_part2.asciistring_0262A0 )
    COP [B2] ( @w5_actor_025E61_part2.code_0266E8, #$0040, #$FF70, #$0040 )
    COP [B2] ( @w5_actor_025E61_part2.code_026961, #$0040, #$FF60, #$0040 )
    COP [05] ( #$0007 )
    COP [01] ( &w5_actor_025E61_part2.asciistring_0262B9 )
    COP [03] ( #1F )
    COP [04]
    COP [01] ( &w5_actor_025E61_part2.asciistring_0262ED )
    COP [03] ( #5B )
    COP [04]
    LDA #$0004
    STA $1B84
    COP [01] ( &w5_actor_025E61_part2.asciistring_026382 )
    LDA #$0003
    STA $1B84
    COP [03] ( #1F )
    COP [04]
    COP [01] ( &w5_actor_025E61_part2.asciistring_026458 )
    COP [09] ( #$0007 )
    COP [05] ( #$0007 )
    COP [01] ( &w5_actor_025E61_part2.asciistring_02648E )
    LDA #$6FC0
    TRB $joy_block_mask
    COP [91]
    COP [0D] ( #00, #1E, #18, &code_025F43 )
    RTL 
}

code_025F43 {
    LDA #$6FC0
    TSB $joy_block_mask
    COP [01] ( &w5_actor_025E61_part2.asciistring_0264C3 )
    BRK #$5E
    COP [0A] ( #23 )
    COP [03] ( #1F )
    COP [04]
    COP [01] ( &w5_actor_025E61_part2.asciistring_026509 )
    COP [16]
    COP [80] ( #26 )
    COP [82]
    COP [80] ( #23 )
    COP [82]
    COP [03] ( #3D )
    COP [04]
    COP [01] ( &w5_actor_025E61_part2.asciistring_026533 )
    COP [80] ( #26 )
    COP [82]
    COP [80] ( #23 )
    COP [82]
    COP [B0] ( @w5_actor_025E61_part2.code_02699C, #$0300 )
    COP [03] ( #3D )
    COP [04]
    COP [80] ( #22 )
    COP [82]
    COP [15]
    COP [05] ( #$0006 )
    COP [03] ( #15 )
    COP [04]
    COP [31] ( #13 )
    COP [03] ( #79 )
    COP [04]
    COP [09] ( #$8805 )
    LDA #$6FC0
    TRB $joy_block_mask

  loc_025FA8:
    COP [17] ( &code_025FF7 )
    COP [91]
    RTL 
}

code_025FAF {
    COP [07] ( #$8900, &code_025FC2 )
    COP [AC] ( @w5_actor_025E61_part2.code_0266FC, #$0230, #$0180, #$0040 )
    BRA loc_025FCD
}

code_025FC2 {
    COP [AC] ( @w5_actor_025E61_part2.code_02670A, #$0220, #$0190, #$0040 )

  loc_025FCD:
    COP [9F] ( #$0080 )
    COP [96]
    COP [80] ( #22 )
    COP [82]
    COP [15]
    BRA loc_025FA8
}

code_025FDC {
    COP [86]
    RTL 
}

code_025FDF {
    COP [01] ( &asciistring_0260F6 )
    RTL 
}

code_025FE4 {
    COP [01] ( &asciistring_026144 )
    LDA #$6FC0
    TSB $joy_block_mask
    COP [09] ( #$8000 )
    COP [17] ( #$0000 )
    RTL 
}

code_025FF7 {
    COP [07] ( #$8900, &code_026018 )
    COP [07] ( #$8901, &code_026018 )
    LDA #$0004
    STA $1B84
    COP [01] ( &w5_actor_025E61_part2.asciistring_026551 )
    LDA #$0003
    STA $1B84
    COP [09] ( #$8901 )
    RTL 
}

code_026018 {
    COP [01] ( &w5_actor_025E61_part2.asciistring_0266DB )
    RTL 
}

code_02601D {
    COP [14] ( #$0181, &code_026025 )
    BRA loc_02602B
}

code_026025 {
    COP [14] ( #$016E, &code_026032 )

  loc_02602B:
    COP [01] ( &asciistring_0260F0 )
    COP [86]
    RTL 
}

code_026032 {
    COP [01] ( &asciistring_026039 )
    COP [86]
    RTL 
}

asciistring_026039 |[10][0E:3C]I am Dr-Leo- [N]I have been watching [N]from the darkness- [FIN]I am going to retrieve[N]the Black Stone, go [N]to the World of Evil [N]and defeat Deathtoll- [FIN]I hope you will come [N]with me- [FIN]The airship dock is at[N]the top floor of the [N]right tower- [FIN]I will be waiting for [N]you- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_0260F0 |[10][0E:3C][JMP:&asciistring_0260F6+M]|

asciistring_0260F6 |[10][::]I am Dr-Leo- [N]I will save the story [N]for later- [FIN]Please save the two [N]soldiers who promised [N]to come with me- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_026144 |[10]You are [02:2]- [N]Birds from GreenWood [N]told me of you- [FIN]The stones you have [N]collected are keys to [N]open the gate to the [N]World of Evil- [FIN]They are the Origins [N]of Power for machines [N]that beckon evil- [FIN]King Magridd holds the[N]last stone- [FIN]We have to free him to[N]get the last stone- [FIN]Go then to the World [N]of Evil and defeat [N]Deathtoll- [JMP:&w5_shared_02706C.asciistring_0270DF]|