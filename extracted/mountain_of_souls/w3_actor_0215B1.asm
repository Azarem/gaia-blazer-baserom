?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_0215B1 {
    COP [14] ( #$00F0, &code_0215B8 ) ; {136625}
    RTL                   ; {136631}
}

code_0215B8 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {136632}
    COP [15]              ; {136637}
    COP [14] ( #$00D4, &code_0215C7 ) ; {136639}
    BRA loc_0215EF        ; {136645}
}

code_0215C7 {
    COP [14] ( #$00EF, &code_0215CF ) ; {136647}
    BRA loc_0215EF        ; {136653}
}

code_0215CF {
    COP [14] ( #$00E9, &code_0215D7 ) ; {136655}
    BRA loc_0215F6        ; {136661}
}

code_0215D7 {
    COP [14] ( #$00F2, &code_0215DF ) ; {136663}
    BRA loc_0215F6        ; {136669}
}

code_0215DF {
    COP [17] ( &code_021661 ) ; {136671}
    COP [05] ( #$0001 )   ; {136675}
    COP [16]              ; {136679}
    COP [17] ( &code_021640 ) ; {136681}
    BRA loc_0215FD        ; {136685}

  loc_0215EF:
    COP [17] ( &code_021657 ) ; {136687}
    COP [91]              ; {136691}
    RTL                   ; {136693}

  loc_0215F6:
    COP [17] ( &code_02165C ) ; {136694}
    COP [91]              ; {136698}
    RTL                   ; {136700}

  loc_0215FD:
    COP [81] ( #1D, #11 ) ; {136701}
    COP [83]              ; {136705}
    COP [81] ( #1B, #0D ) ; {136707}
    COP [83]              ; {136711}
    COP [96]              ; {136713}
    COP [81] ( #1D, #02 ) ; {136715}
    COP [83]              ; {136719}
    COP [81] ( #1B, #06 ) ; {136721}
    COP [83]              ; {136725}
    COP [81] ( #1D, #02 ) ; {136727}
    COP [83]              ; {136731}
    COP [81] ( #1B, #06 ) ; {136733}
    COP [83]              ; {136737}
    COP [81] ( #1D, #0E ) ; {136739}
    COP [83]              ; {136743}
    COP [81] ( #1C, #19 ) ; {136745}
    COP [83]              ; {136749}
    COP [97]              ; {136751}
    COP [80] ( #1D )      ; {136753}
    COP [82]              ; {136756}
    COP [80] ( #1A )      ; {136758}
    COP [82]              ; {136761}
    BRA loc_0215FD        ; {136763}

  loc_02163D:
    COP [91]              ; {136765}
    RTL                   ; {136767}
}

code_021640 {
    LDA $0016, X          ; {136768}
    AND #$FFEF            ; {136771}
    STA $0016, X          ; {136774}
    COP [01] ( &asciistring_021666 ) ; {136777}
    LDA $0016, X          ; {136781}
    ORA #$0010            ; {136784}
    STA $0016, X          ; {136787}
    RTL                   ; {136790}
}

code_021657 {
    COP [01] ( &asciistring_02168D ) ; {136791}
    RTL                   ; {136795}
}

code_02165C {
    COP [01] ( &asciistring_0216BE ) ; {136796}
    RTL                   ; {136800}
}

code_021661 {
    COP [01] ( &asciistring_0216EF ) ; {136801}
    RTL                   ; {136805}
}

asciistring_021666 |[10]I have no time to [N]talk- I am going to [N]lose the race- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_02168D |[10]We are snail jockeys- [N]We are waiting for the[N]race to start- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_0216BE |[10]All the jockeys are [N]here but the race [N]track is not yet [N]completed- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_0216EF |[10]We are waiting for the[N]race to start- [JMP:&w3_shared_02249A.asciistring_02251E]|