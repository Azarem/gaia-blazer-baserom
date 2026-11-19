?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_021455 {
    COP [14] ( #$00EF, &code_02145C )
    RTL 
}

code_02145C {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [15]
    COP [14] ( #$00D4, &code_02146B )
    BRA loc_021493
}

code_02146B {
    COP [14] ( #$00F0, &code_021473 )
    BRA loc_021493
}

code_021473 {
    COP [14] ( #$00E9, &code_02147B )
    BRA loc_02149A
}

code_02147B {
    COP [14] ( #$00F2, &code_021483 )
    BRA loc_02149A
}

code_021483 {
    COP [17] ( &code_021511 )
    COP [05] ( #$0001 )
    COP [16]
    COP [17] ( &code_0214F0 )
    BRA loc_0214A1

  loc_021493:
    COP [17] ( &code_021507 )
    COP [91]
    RTL 

  loc_02149A:
    COP [17] ( &code_02150C )
    COP [91]
    RTL 

  loc_0214A1:
    COP [81] ( #1D, #06 )
    COP [83]
    COP [81] ( #1B, #02 )
    COP [83]
    COP [81] ( #1D, #0B )
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
    COP [81] ( #1C, #1B )
    COP [83]
    COP [97]
    COP [80] ( #1D )
    COP [82]
    COP [80] ( #1A )
    COP [82]
    BRA loc_0214A1

  loc_0214ED:
    COP [91]
    RTL 
}

code_0214F0 {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_021516 )
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    RTL 
}

code_021507 {
    COP [01] ( &asciistring_02153D )
    RTL 
}

code_02150C {
    COP [01] ( &asciistring_021569 )
    RTL 
}

code_021511 {
    COP [01] ( &asciistring_02159A )
    RTL 
}

asciistring_021516 |[10]I have no time to [N]talk- I am going to [N]lose the race- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_02153D |[10]We are snail jockeys- [N]This snail is called [N]Flash- [N]I am the fastest! [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_021569 |[10]All the jockeys are [N]here but the race [N]track is not yet [N]completed- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_02159A |[10]I am going to win this[N]race! [JMP:&w3_shared_02249A.asciistring_02251E]|