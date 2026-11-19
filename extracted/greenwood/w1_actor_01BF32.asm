?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w1_shared_01EBC2'

!joy_block_mask                 0326
!scroll_bg1_y                   033C

---------------------------------------------

code_01BF32 {
    COP [14] ( #$0063, &code_01BF39 )
    RTL 
}

code_01BF39 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [AC] ( @code_01C261, #$0030, #$0200, #$2040 )
    COP [17] ( &code_01BFED )
    COP [07] ( #$0306, &code_01BF62 )
    COP [17] ( &code_01C015 )
    COP [AC] ( @code_01C0B0, #$00A0, #$00B0, #$0050 )
}

code_01BF62 {
    COP [15]
    COP [91]
    RTL 
}

code_01BF67 {
    COP [16]
    COP [81] ( #16, #09 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [87]
    COP [80] ( #17 )
    COP [82]
    COP [9F] ( #$0008 )
    COP [80] ( #16 )
    COP [82]
    COP [15]
    COP [17] ( &code_01C009 )
    COP [91]
    RTL 
}

code_01BF8C {
    COP [09] ( #$8002 )

  code_01BF90:
    COP [16]
    COP [80] ( #25 )
    COP [82]
    COP [80] ( #26 )
    COP [82]
    BRK #$4A
    LDA #$2F80
    TSB $joy_block_mask
    COP [03] ( #08 )
    LDA $002E, X
    CLC 
    ADC $scroll_bg1_y
    STA $scroll_bg1_y
    COP [1B] ( &code_01BFB7, #$0002 )
}

code_01BFB7 {
    COP [04]
    LDA #$2F80
    TRB $joy_block_mask
    COP [07] ( #$0002, &code_01BF8C )
    COP [AC] ( @code_01C08A, #$00A0, #$0010, #$0050 )
    COP [1B] ( &code_01BFD6, #$005A )
}

code_01BFD6 {
    COP [80] ( #12 )
    COP [82]
    COP [80] ( #15 )
    COP [82]
    COP [15]
    COP [17] ( &code_01C015 )
    COP [09] ( #$8306 )
    COP [91]
    RTL 
}

code_01BFED {
    COP [14] ( #$006F, &code_01BFF8 )
    COP [01] ( &asciistring_01C01A )
    RTL 
}

code_01BFF8 {
    COP [01] ( &asciistring_01C043 )
    COP [17] ( &code_01C004 )
    COP [27] ( &code_01BF67 )
}

code_01C004 {
    COP [01] ( &asciistring_01C043 )
    RTL 
}

code_01C009 {
    COP [01] ( &asciistring_01C052 )
    COP [17] ( #$0000 )
    COP [27] ( &code_01BF90 )
}

code_01C015 {
    COP [01] ( &asciistring_01C065 )
    RTL 
}

asciistring_01C01A |[10]If you help me [N]cross the river I will[N]give you something- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01C043 |[10]Follow me- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01C052 |[10]Stand back and watch! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01C065 |[10]What did you think? [N]I hope this helped- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

code_01C08A {
    JSL $@w0_shared_01B161.code_01B161
    STZ $0014, X
    COP [03] ( #28 )
    LDA $0002, X
    CLC 
    ADC #$0004
    STA $0002, X
    COP [04]
    COP [17] ( &code_01C0C4 )
    SEP #$20
    LDA #$^w0_shared_01B161.code_01B17C
    PHA 
    REP #$20
    LDA #$&w0_shared_01B161.code_01B17C-1
    PHA 
    RTL 
}

code_01C0B0 {
    JSL $@w0_shared_01B161.code_01B161
    COP [17] ( &code_01C0C4 )
    SEP #$20
    LDA #$^w0_shared_01B161.code_01B17C
    PHA 
    REP #$20
    LDA #$&w0_shared_01B161.code_01B17C-1
    PHA 
    RTL 
}

code_01C0C4 {
    COP [18] ( #40, &code_01C0CE )
    COP [01] ( &asciistring_01C224 )
    RTL 
}

code_01C0CE {
    COP [18] ( #2A, &code_01C118 )
    COP [18] ( #2B, &code_01C118 )
    COP [18] ( #2C, &code_01C118 )
    COP [18] ( #2D, &code_01C118 )
    COP [18] ( #2E, &code_01C118 )
    COP [18] ( #2F, &code_01C118 )
    COP [18] ( #30, &code_01C118 )
    COP [18] ( #31, &code_01C118 )
    COP [01] ( &asciistring_01C1D8 )
    COP [0B] ( #2A )
    COP [0B] ( #2B )
    COP [0B] ( #2C )
    COP [0B] ( #2D )
    COP [0B] ( #2E )
    COP [0B] ( #2F )
    COP [0B] ( #30 )
    COP [0B] ( #31 )
    BRK #$5E
    COP [0A] ( #40 )
    RTL 
}

code_01C118 {
    COP [01] ( &asciistring_01C11D )
    RTL 
}

asciistring_01C11D |[10]The Master s Emblems [N]are all over the [N]world------- [FIN]They are fairly [N]difficult to find- [FIN]Collect all 8 emblems,[N]will not require GEMs [N]when casting magic- [FIN]This will make [N]fighting much easier [N]If you collect all 8, [N]bring them to me- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01C1D8 |[10][02:2], [N]you collected all 8 [N]emblems- [FIN]I will now give you [N][03:24]the Magic Bell- [N][03:20]You have fought well! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01C224 |[10]The Magic Bell [N]enables you to use [N]magic without GEMs- [FIN][02:2], good luck! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

code_01C261 {
    COP [17] ( &code_01C26D )
    COP [91]
    COP [80] ( #23 )
    COP [82]
    RTL 
}

code_01C26D {
    COP [01] ( &asciistring_01C272 )
    RTL 
}

asciistring_01C272 |[10][0A]There█once█was█a█raft[N]made█from█the█bark█of[N]my█branches-[FIN]You█must█find█this[N]raft-█I█believe█it[N]might█be█able[N]help█you█in█some█way-[JMP:&w1_shared_01EBC2.asciistring_01EC46]|