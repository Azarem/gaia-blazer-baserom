?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_0215B1 {
    COP [14] ( #$00F0, &code_0215B8 )
    RTL 
}

code_0215B8 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [15]
    COP [14] ( #$00D4, &code_0215C7 )
    BRA loc_0215EF
}

code_0215C7 {
    COP [14] ( #$00EF, &code_0215CF )
    BRA loc_0215EF
}

code_0215CF {
    COP [14] ( #$00E9, &code_0215D7 )
    BRA loc_0215F6
}

code_0215D7 {
    COP [14] ( #$00F2, &code_0215DF )
    BRA loc_0215F6
}

code_0215DF {
    COP [17] ( &code_021661 )
    COP [05] ( #$0001 )
    COP [16]
    COP [17] ( &code_021640 )
    BRA loc_0215FD

  loc_0215EF:
    COP [17] ( &code_021657 )
    COP [91]
    RTL 

  loc_0215F6:
    COP [17] ( &code_02165C )
    COP [91]
    RTL 

  loc_0215FD:
    COP [81] ( #1D, #11 )
    COP [83]
    COP [81] ( #1B, #0D )
    COP [83]
    COP [96]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [81] ( #1B, #06 )
    COP [83]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [81] ( #1B, #06 )
    COP [83]
    COP [81] ( #1D, #0E )
    COP [83]
    COP [81] ( #1C, #19 )
    COP [83]
    COP [97]
    COP [80] ( #1D )
    COP [82]
    COP [80] ( #1A )
    COP [82]
    BRA loc_0215FD

  loc_02163D:
    COP [91]
    RTL 
}

code_021640 {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_021666 )
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    RTL 
}

code_021657 {
    COP [01] ( &asciistring_02168D )
    RTL 
}

code_02165C {
    COP [01] ( &asciistring_0216BE )
    RTL 
}

code_021661 {
    COP [01] ( &asciistring_0216EF )
    RTL 
}

asciistring_021666 |[10]I have no time to [N]talk- I am going to [N]lose the race- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_02168D |[10]We are snail jockeys- [N]We are waiting for the[N]race to start- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_0216BE |[10]All the jockeys are [N]here but the race [N]track is not yet [N]completed- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_0216EF |[10]We are waiting for the[N]race to start- [JMP:&w3_shared_02249A.asciistring_02251E]|