?BANK 00

---------------------------------------------

code_004F4D {
    LDY $039A
    LDA $0016, Y
    BIT #$0400
    BNE loc_004F59
    RTL 

  loc_004F59:
    STX $039A
    LDA $0000, Y
    STA $0000, X
    LDA $0002, Y
    STA $0002, X
    COP [1B] ( &code_004F6E, #$00B4 )
}

code_004F6E {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [85] ( @code_004F9E )

  code_004F7C:
    COP [80] ( #1F )
    COP [82]
    COP [08] ( #$8000, &code_004F7C )
    COP [85] ( @code_004FA9 )
    COP [81] ( #1F, #03 )
    COP [83]
    COP [10] ( #$0215, #01, #$0078, #$00C8 )
    COP [91]
    RTL 
}

code_004F9E {
    COP [01] ( &asciistring_004FB6 )
    COP [09] ( #$8000 )
    COP [86]
    RTL 
}

code_004FA9 {
    COP [A8] ( #$8000, #0D )
    COP [92] ( #48 )
    COP [94]
    COP [86]
    RTL 
}

asciistring_004FB6 |[10]Some people believe [N]being constantly [N]reincarnated means [N]everlasting suffering-[FIN]Being alive is [N]suffering for some [N]creatures- [FIN]You will find out what[N]I mean- [12][08:408][END]|