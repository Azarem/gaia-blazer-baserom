?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_0212FE {
    COP [14] ( #$00D4, &code_021305 )
    RTL 
}

code_021305 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [15]
    COP [14] ( #$00EF, &code_021314 )
    BRA loc_02133C
}

code_021314 {
    COP [14] ( #$00F0, &code_02131C )
    BRA loc_02133C
}

code_02131C {
    COP [14] ( #$00E9, &code_021324 )
    BRA loc_021343
}

code_021324 {
    COP [14] ( #$00F2, &code_02132C )
    BRA loc_021343
}

code_02132C {
    COP [17] ( &code_0213BA )
    COP [05] ( #$0001 )
    COP [16]
    COP [17] ( &code_021399 )
    BRA loc_02134A

  loc_02133C:
    COP [17] ( &code_0213B0 )
    COP [91]
    RTL 

  loc_021343:
    COP [17] ( &code_0213B5 )
    COP [91]
    RTL 

  loc_02134A:
    COP [81] ( #1D, #06 )
    COP [83]
    COP [81] ( #1B, #04 )
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
    COP [81] ( #1C, #1D )
    COP [83]
    COP [97]
    COP [80] ( #1D )
    COP [82]
    COP [80] ( #1A )
    COP [82]
    BRA loc_02134A

  loc_021396:
    COP [91]
    RTL 
}

code_021399 {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_0213BF )
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    RTL 
}

code_0213B0 {
    COP [01] ( &asciistring_0213E9 )
    RTL 
}

code_0213B5 {
    COP [01] ( &asciistring_021409 )
    RTL 
}

code_0213BA {
    COP [01] ( &asciistring_02143E )
    RTL 
}

asciistring_0213BF |[10]I have no time to [N]talk- I think I am [N]going to lose the [N]race- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_0213E9 |[10]We are snail jockeys- [N]This snail is called [N]Legend- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_021409 |[10]All the jockeys are [N]here, but the race [N]track is not completed[N]yet- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_02143E |[10]I am going to win this[N]race! [JMP:&w3_shared_02249A.asciistring_02251E]|