?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

!joy_pressed                    0322
!joy_block_mask                 0326

---------------------------------------------

code_0229DF {
    COP [14] ( #$010C, &code_0229E6 )
    RTL 
}

code_0229E6 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_022A69 )
    COP [15]

  code_0229F1:
    COP [91]
    COP [03] ( #02 )
    COP [80] ( #08 )
    COP [82]
    LDA $joy_pressed
    AND #$0200
    BEQ loc_022A2E
    COP [0D] ( #00, #04, #10, &code_022A0C )
    BRA loc_022A2E
}

code_022A0C {
    COP [04]
    LDA #$2F80
    TSB $joy_block_mask
    COP [16]
    COP [81] ( #1D, #10 )
    COP [83]
    COP [15]
    LDA #$2F80
    TRB $joy_block_mask
    COP [91]
    COP [0D] ( #00, #03, #10, &code_022A32 )
    RTL 

  loc_022A2E:
    COP [27] ( &code_0229F1 )
}

code_022A32 {
    COP [07] ( #$9A06, &code_022A45 )
    COP [01] ( &asciistring_022ADC )
    BRK #$5E
    COP [0A] ( #30 )
    COP [09] ( #$9A06 )
}

code_022A45 {
    COP [91]
    RTL 
}

code_022A48 {
    LDA #$2F80
    TSB $joy_block_mask
    COP [80] ( #1B )
    COP [82]
    COP [01] ( &asciistring_022A9D )
    BRK #$5E
    COP [0A] ( #0D )
    COP [80] ( #1C )
    COP [82]
    LDA #$2F80
    TRB $joy_block_mask
    BRA code_0229F1
}

code_022A69 {
    COP [18] ( #0D, &code_022A73 )
    COP [01] ( &asciistring_022AB8 )
    RTL 
}

code_022A73 {
    COP [01] ( &asciistring_022A7B )
    COP [27] ( &code_022A48 )
}

asciistring_022A7B |[10]Take the Mystic Armor [N]from my drawer- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_022A9D |[10][02:2] received [N][03:24]Mystic Armor- [03:20][JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_022AB8 |[10]My body is made from [N]the trees in [N]GreenWood- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_022ADC |[10][02:2] found [N][03:24]Master s Emblem G- [03:20][JMP:&w4_shared_023F33.asciistring_023FA3]|